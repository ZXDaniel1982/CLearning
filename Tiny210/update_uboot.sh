#!/bin/sh
#######################################################################
#  U-boot install/upgrade script
#######################################################################
# This script can be used to upgrade Uboot on a CSR1000 which either has
# U-boot already installed, or winmon > 0.4.13
#
# This process is potentially dangerous (suspectible to power outage)
# and is not easily reversable, so make sure you really, really need
# to run this before doing so.
#
#######################################################################
TARGET_UBOOT=/boot/u-boot.bin
UBOOT_PARTITION=/dev/mtd3
ENV_PARTITION=/dev/mtd4

#######################################################################
# When upgrading from winmon, this function is used to store
# the existing winmon environment variables into bash variables that
# can be later converted into the u-boot format
#######################################################################
store_winmon_variables()
{
    echo "Storing winmon environment variables"

    active=$(upgrade env --env ACTIVE_SOFTWARE)
    winmon_ethaddr=$(upgrade env --env BOARD_MAC_ETHX)
    winmon_ipaddr=$(upgrade env --env BOARD_IP_ADDRESS)
    winmon_gateway=$(upgrade env --env BOARD_GATEWAY)
    winmon_netmask=$(upgrade env --env  BOARD_SUBNET_MASK)
    wd_disabled=$(upgrade env --env WATCHDOG_DISABLED)
    debug_port=$(upgrade env --env DEBUG_MANAGEMENT_PORT)
    start_iss=$(upgrade env --env START_ISS)
    fixed_serial=$(upgrade env --env FIXED_SERIAL)
    boot_log=$(upgrade env --env BOOT_LOG)
    sd_sync=$(upgrade env --env SD_SYNC_DISABLED)

    if [ $active == "1" ]; then
        winmon_bootcmd=$(upgrade env --env BOOT_CMD_1)
        winmon_kernel=$(upgrade env --env KERNEL_CMDLINE_1)
    else
        winmon_bootcmd=$(upgrade env --env BOOT_CMD_2)
        winmon_kernel=$(upgrade env --env KERNEL_CMDLINE_2)
    fi
}


#######################################################################
# Erase the partition in NOR used to store the U-boot image
#######################################################################
erase_boot_partition()
{
    echo "Erasing NOR flash bootloader"

    # erase winmon1, use this to store the uboot image
    flash_erase $UBOOT_PARTITION 0 0
}

#######################################################################
# Erase the environment variables from NOR
#######################################################################
erase_environment()
{
    # erase winmon2, re-use this for environment variables
    echo "Erasing NOR flash environment variables"
    flash_erase $ENV_PARTITION 0 0
}

#######################################################################
# Write the provided u-boot binary file into the boot partition
#######################################################################
write_uboot_image()
{
    echo "Loading U-boot into NOR flash"
    dd if=$TARGET_UBOOT of=$UBOOT_PARTITION
}


#######################################################################
# if we have upgraded from winmon, then this function will be called
# to restore the environment variables to the state they were before the
# upgrade, but in the new u-boot format.
########################################$##############################
restore_winmon_variables()
{
    echo "Restoring environment variables"

    # set u-boot environment variables based on the values from winmon
    fw_setenv ethaddr $winmon_ethaddr
    fw_setenv ipaddr $winmon_ipaddr
    fw_setenv gatewayip $winmon_gateway
    fw_setenv netmask $winmon_netmask
 
    # some older boards didn't use the ACTIVE_SOFTWARE environment variable
    # so if this isn't set, then set it to 1
    if [ "$active" == "" ]; then
        active=1;
    fi
    fw_setenv ACTIVE_SOFTWARE $active
    fw_setenv WATCHDOG_DISABLED $wd_disabled
    fw_setenv START_ISS $start_iss
    fw_setenv FIXED_SERIAL $fixed_serial
    fw_setenv SD_SYNC_DISABLED $sd_sync

    # check to see if the debug management port is in a valid range, and if so restore it
    if [ "$debug_port" != "" ]; then
        if [ $debug_port -ge 0 ] && [ $debug_port -le 5 ]; then
            fw_setenv DEBUG_MANAGEMENT_PORT $debug_port
        fi
    fi

    # parse kernel cmdline and bootcmd to determine if we are using NFS or flash
    if ! echo "$winmon_bootcmd" | grep -q "nand" && echo "$winmon_bootcmd" | grep -q "eld"; then
        boot_img=""
        if echo "$winmon_bootcmd" | grep -q "vmlinux"; then
            echo "vmlinux"
            boot_img=$(echo "$winmon_bootcmd" | awk '{print $3}' | sed 's/vmlinux/uImage/' | sed 's/;//')
        elif echo "$winmon_bootcmd" | grep -q "vmlinuz"; then
            boot_img=$(echo "$winmon_bootcmd" | awk '{print $3}' |  sed 's/vmlinuz/uImage/' | sed 's/;//')
        fi
        fw_setenv boot_img $boot_img
    fi

    # parse cmdline to get NFS server / rootpath
    for item in ${winmon_kernel}
    do
        if echo "$item" | grep -q "nfsroot="; then
            nfs=$(echo "$item" | awk -F '=' '{print $2}')
            server_ip=$(echo "$nfs" | awk -F':' '{print $1}')
            rootpath=$(echo "$nfs" | awk -F':' '{print $2}')
            fw_setenv serverip $server_ip
            fw_setenv rootpath $rootpath
            fw_setenv bootcmd run nfs
            break
        fi
    done

    # update CONSOL_LOG / silent mode (if enabled)
    if [ "$boot_log" != "" ]; then
        if ! echo "$boot_log" | grep -iq "disabled"; then
            fw_setenv silent 1
        fi
    fi
}

#######################################################################
# this function can be used to compare two version numbers
# if $2 is greater or equal to $1 then 0 will be returned, otherwise
# 1 will be returned
#######################################################################
do_version_check() {
   ver=$(echo -ne "$1\n$2" | sort -n | head -n1)
    if [ "$1" == "$2" ]; then
        return 0
    elif [ "$1" == "$ver" ]; then
        return 0
    else
        return 1
    fi
}

#######################################################################
# check for U-boot or winmon versions > 0.4.13
#######################################################################
check_bootloader_version()
{
    echo "Current bootloader is $BOOTLOADER_VERSION"

    # check to see if we are running uboot
    if echo "$BOOTLOADER_VERSION" | grep -q "U-Boot.*"; then
        return 0;
    fi;

    # assume we are running winmon
    winmon_version=$(echo $BOOTLOADER_VERSION | grep "Winmon" | sed 's/Winmon-//')
    if [ "$winmon_version" == "" ]; then
        echo "Unable to determine winmon version"
        exit
    else
       if do_version_check "0.4.13" "$winmon_version"; then
           return 1;
       else
           echo "Winmon version $winmon_version is not supported, please upgrade to 0.4.13 or newer"
           exit 1
       fi
   fi
   return 0
}

#######################################################################
# check that a new u-boot binary exists, and looks like a valid u-boot
# image
#######################################################################
check_new_uboot_version()
{
    if [ ! -f $TARGET_UBOOT ]; then
        echo "cannot find $TARGET_UBOOT"
        exit 1
    fi
    new_uboot=$(strings $TARGET_UBOOT | grep 'U-Boot.*-')
    if echo "$new_uboot" | grep -q "U-Boot.*"; then
        echo "Installing $new_uboot"
    else
        echo "$TARGET_UBOOT doesn't appear to be a U-boot binary"
        exit 1
    fi
}

#######################################################################
# U-boot upgrade process begins here
#######################################################################
check_bootloader_version
winmon_upgrade=$?

check_new_uboot_version

if [ $winmon_upgrade == 1 ]; then
    store_winmon_variables
fi

erase_boot_partition

if [ $winmon_upgrade == 1 ]; then
    erase_environment
fi

write_uboot_image

if [ $winmon_upgrade == 1 ]; then
    restore_winmon_variables
fi

echo "Done, rebooting"
reboot


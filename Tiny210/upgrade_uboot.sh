#!/bin/sh
#######################################################################
#  U-boot upgrade script
#######################################################################
# This script can be used to upgrade Uboot on a CTR8740
#
# This process is potentially dangerous (suspectible to power outage)
# and is not easily revere to previous version. If your SD card bricks,
# please fresh the whole SD card to a usable version to bring up
# the board.
#
#######################################################################
TARGET_UBOOT=/boot/u-boot.bin
SD_CARD_DEV=/dev/mmcblk0


#######################################################################
# When this function is used to store the key environment variables
# into bash variables that can be later restored
#######################################################################
store_variables()
{
    echo "Storing u-boot environment variables"

    fdt=$(fw_printenv -n fdt)
    fdtaddr=$(fw_printenv -n fdt_addr)
    fdtaddrr=$(fw_printenv -n fdt_addr_r)
    fdthigh=$(fw_printenv -n fdt_high)
    bootselected=$(fw_printenv -n bootselected)
    bootdelay=$(fw_printenv -n bootdelay)
    ethact=$(fw_printenv -n ethact)
    ethprime=$(fw_printenv -n ethprime)
    ethaddr=$(fw_printenv -n ethaddr)
    eth1addr=$(fw_printenv -n eth1addr)
    eth2addr=$(fw_printenv -n eth2addr)
    eth3addr=$(fw_printenv -n eth3addr)
    eth4addr=$(fw_printenv -n eth4addr)
    eth5addr=$(fw_printenv -n eth5addr)
    eth6addr=$(fw_printenv -n eth6addr)
    ipaddr=$(fw_printenv -n ipaddr)
    gateway=$(fw_printenv -n gatewayip)
    netmask=$(fw_printenv -n netmask)
    macpooladdr=$(fw_printenv -n macpool_addr)
    macpoolcount=$(fw_printenv -n macpool_count)
    wddisabled=$(fw_printenv -n WATCHDOG_DISABLED)

}


#######################################################################
# Write the provided u-boot image into the SD card boot partition
#######################################################################
write_uboot_image()
{
    echo "Fresh U-boot into SD card"
    dd if=${TARGET_UBOOT} of=${SD_CARD_DEV} seek=8 bs=512
}


#######################################################################
# This function is used to restore the key environment variables
# to the state they were before the u-boot upgrade.
# The users specificed env should maintained by themselves.
########################################$##############################
restore_variables()
{
    echo "Restoring u-boot environment variables"

    # set boot environment variables
    fw_setenv bootdelay $bootdelay
    fw_setenv fdt $fdt
    fw_setenv fdt_addr $fdtaddr
    fw_setenv fdt_addr_r $fdtaddrr
    fw_setenv fdt_high $fdthigh

    # set ethernet u-boot environment variables
    fw_setenv ethaddr $ethaddr
    fw_setenv eth1addr $eth1addr
    fw_setenv eth2addr $eth2addr
    fw_setenv eth3addr $eth3addr
    fw_setenv eth4addr $eth4addr
    fw_setenv eth5addr $eth5addr
    fw_setenv eth6addr $eth6addr
    fw_setenv ethact $ethact
    fw_setenv ethprime $ethprime

    if [ "$ipaddr" != "" ]; then
        fw_setenv ipaddr $ipaddr
    fi

    if [ "$gateway" != "" ]; then
        fw_setenv gatewayip $gateway
    fi

    if [ "$netmask" != "" ]; then
        fw_setenv netmask $netmask
    fi

    if [ "$macpoolcount" != "" ]; then
        fw_setenv macpool_count $macpoolcount
    fi

    if [ "$macpooladdr" != "" ]; then
        fw_setenv macpool_addr $macpooladdr
    fi


    # set activated software partition
    fw_setenv bootselected $bootselected

    # set watchdog status
    fw_setenv WATCHDOG_DISABLED $wddisabled

}

#######################################################################
# check that a new u-boot binary exists, and looks like a valid u-boot
# image
#######################################################################
check_uboot_version()
{
    if [ ! -f $TARGET_UBOOT ]; then
        echo "cannot find $TARGET_UBOOT"
        exit 1
    fi
    new_uboot=$(strings $TARGET_UBOOT | grep 'U-Boot.* +')
    if echo "$new_uboot" | grep -q "U-Boot.* +"; then
        echo "Installing $new_uboot"
    else
        echo "$TARGET_UBOOT doesn't appear to be a U-boot binary"
        exit 1
    fi
}

#######################################################################
# U-boot upgrade process begins here
#######################################################################
if [ "$1" != "" ]; then
    TARGET_UBOOT="$1"
fi

check_uboot_version

store_variables

write_uboot_image

restore_variables


echo "Done, Need to reboot"
# Do not reboot here as software loading will call this function when
# activate or rollback software.
#reboot


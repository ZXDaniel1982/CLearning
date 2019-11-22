#!/bin/bash -e

# SD card formatting script

if [ $# -lt 2 ]
then
    echo "Usage: $0 <hw_type> <mmc_device> [<sd_fs tarball>]"
    echo "<hw_type>: one of 'V1', 'V2', 'V3'"
    echo "<mmc_device>: MMC block device of SD card .e.g /dev/mmcblk0"
    echo "<sd_fs tarball>: (Optional) A SD filesystem tarball to use"
    exit 0
fi

SD_CARD_DEV=$2
SD_CARD_P1_DEV="${SD_CARD_DEV}p1"
SD_MOUNT_POINT=".sdcardtmp"
SD_FS_URL="http://nz-swbuild02:8080/job/CSR1000Release/lastSuccessfulBuild/artifact/BUILD.CSR1000V3/staging/sd_fs.tar.bz2"

umount "${SD_CARD_P1_DEV}" || true

if [ $# -eq 3 ]
then
    SD_FS_TAR=$3
else
    SD_FS_TAR="sd_fs.tar.bz2"
    if [ "$1" = "V1" ]
    then
        SD_FS_URL="http://nz-swbuild02:8080/job/CSR1000Release/lastSuccessfulBuild/artifact/BUILD.CSR1000/staging/sd_fs.tar.bz2"
    fi
    if [ "$1" = "V2" ]
    then
        SD_FS_URL="http://nz-swbuild02:8080/job/CSR1000Release/lastSuccessfulBuild/artifact/BUILD.CSR1000V2/staging/sd_fs.tar.bz2"
    fi
    if [ "$1" = "V3" ]
    then
        SD_FS_URL="http://nz-swbuild02:8080/job/CSR1000Release/lastSuccessfulBuild/artifact/BUILD.CSR1000V3/staging/sd_fs.tar.bz2"
    fi
    rm -f "${SD_FS_TAR}"
    wget "${SD_FS_URL}"
fi

echo "Formatting SD card ${SD_CARD_DEV}"

parted -- "${SD_CARD_DEV}" mklabel msdos
parted -- "${SD_CARD_DEV}" mkpart primary 4 1992

sleep 3 # Wait for automount
umount "${SD_CARD_P1_DEV}" || true
mkfs.ext4 -O^huge_file  "${SD_CARD_P1_DEV}"

rm -rf "${SD_MOUNT_POINT}"
mkdir "${SD_MOUNT_POINT}"

mount -t ext4 "${SD_CARD_P1_DEV}" "${SD_MOUNT_POINT}"

tar xf "${SD_FS_TAR}" -C "${SD_MOUNT_POINT}"
umount "${SD_MOUNT_POINT}"
rm -r "${SD_MOUNT_POINT}"

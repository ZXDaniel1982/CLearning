#!/bin/bash -e

sudo dd if=./barebox.s5p of=/dev/sdb bs=512 seek=1
sudo dd if=./uImage of=/dev/sdb bs=512 seek=2048

#!/bin/bash
set -e

# On the computer
MYHOME=$HOME
MYDESKTOP=$HOME/Desktop
DEST_DIR="Pictures from Phone `date "+%Y-%m-%d"`"

# On the phone
CAMERA_SOURCE_DIR="/storage/0587-1605/DCIM/Camera"


# 1. make the dest dir and cd into it
cd $MYDESKTOP
mkdir "$DEST_DIR"

# list files that will be downloaded:
echo "The following files will be adb-pulled, converted, and saved to $DEST_DIR"
adb shell ls "$CAMERA_SOURCE_DIR"

# 2. PULL
adb pull $CAMERA_SOURCE_DIR "$DEST_DIR"


echo "Done"

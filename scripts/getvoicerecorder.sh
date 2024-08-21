#!/bin/bash

# On the computer
MYHOME=$HOME
MYDESKTOP=$HOME/Desktop
DEST_DIR="Voice Recordings `date "+%Y-%m-%d"`"

# On the phone
VOICE_RECORDER_SOURCE_DIR="/sdcard/EasyVoiceRecorder"


# 1. make the dest dir and cd into it
cd $MYDESKTOP
mkdir "$DEST_DIR"
cd "$DEST_DIR"

# list files that will be downloaded:
echo "The following files will be adb-pulled, converted, and saved to $DEST_DIR"
adb shell ls "$VOICE_RECORDER_SOURCE_DIR"


# 2. PULL
adb shell "cd $VOICE_RECORDER_SOURCE_DIR; tar -cf allwavs.tar *wav"
adb pull $VOICE_RECORDER_SOURCE_DIR/allwavs.tar allwavs.tar


# 3. PROCESS
tar -xf allwavs.tar

for f in *.wav; do
  echo "Converting $f to mp3...";
  ffmpeg -hide_banner -loglevel panic    -i "$f" "${f%.wav}.mp3";
done

# set timestamp to match what was on the original .wav files
for f in *.wav; do
  gtouch -d "$(date -R -r "$f")" "${f%.wav}.mp3";
done


# 4. cleanup
rm *wav
adb shell "rm $VOICE_RECORDER_SOURCE_DIR/allwavs.tar"
rm allwavs.tar
echo "Deleting all .wav files from phone..."
adb shell "rm $VOICE_RECORDER_SOURCE_DIR/*wav"

echo "Done"

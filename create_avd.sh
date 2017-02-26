#!/bin/bash
if [ ${TEST} == "android" ]; then
    echo no | android create avd --force --name test --target $ANDROID_TARGET --abi $ANDROID_ABI --sdcard 800M
    emulator -avd test -memory 4000 -noskin -no-audio -cache-size 400 -netfast -no-window -no-boot-anim &
    android-wait-for-emulator
    echo "EMULATOR STARTED"
    adb shell svc power stayon true
    adb shell input keyevent 82 &
    cat $HOME/.android/avd/test.avd/config.ini
    adb devices
    sleep 10
    adb -e logcat *:W | tee logcat.log > /dev/null 2>&1 &
fi
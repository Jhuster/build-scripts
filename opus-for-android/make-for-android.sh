#!/bin/bash
ndk-build NDK_PROJECT_PATH=. APP_BUILD_SCRIPT=./Android.mk $1

if [ x"$1" == x"clean" ]
then
rm -rf obj
rm -rf libs
fi

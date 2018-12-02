#!/bin/bash
LOCAL_PATH=`pwd`
INC_DIR=$LOCAL_PATH/ffmpeg/release/android/inc
LIB_DIR=$LOCAL_PATH/ffmpeg/release/android/libs/

if [ ! -n "$ANDROID_NDK" ]; then
    echo "Please export ANDROID_NDK=[path] first !"
    exit
fi

if [ ! -d "./ffmpeg" ]; then
  git clone git@github.com:FFmpeg/FFmpeg ffmpeg
fi

cd ffmpeg
rm -rf config.h
rm -rf release/android
mkdir -p release/android

ANDROID_SYSROOT=$ANDROID_NDK/sysroot

ARM_PLATFORM=$ANDROID_NDK/platforms/android-28/arch-arm/
ARM_PREBUILT=$ANDROID_NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64

ARM64_PLATFORM=$ANDROID_NDK/platforms/android-28/arch-arm64/
ARM64_PREBUILT=$ANDROID_NDK/toolchains/aarch64-linux-android-4.9/prebuilt/darwin-x86_64

X86_PLATFORM=$ANDROID_NDK/platforms/android-28/arch-x86/
X86_PREBUILT=$ANDROID_NDK/toolchains/x86-4.9/prebuilt/darwin-x86_64

X86_64_PLATFORM=$ANDROID_NDK/platforms/android-28/arch-x86_64/
X86_64_PREBUILT=$ANDROID_NDK/toolchains/x86_64-4.9/prebuilt/darwin-x86_64

function build_one
{
if [ $ARCH == "arm" ]
then
    PLATFORM=$ARM_PLATFORM
    PREBUILT=$ARM_PREBUILT
    HOST=arm-linux-androideabi
elif [ $ARCH == "arm64" ]
then
    PLATFORM=$ARM64_PLATFORM
    PREBUILT=$ARM64_PREBUILT
    HOST=aarch64-linux-android
elif [ $ARCH == "x86" ]
then
    PLATFORM=$X86_PLATFORM
    PREBUILT=$X86_PREBUILT
    HOST=i686-linux-android
else
    PLATFORM=$X86_64_PLATFORM
    PREBUILT=$X86_64_PREBUILT
    HOST=x86_64-linux-android
fi

pushd ./
./configure --target-os=linux \
    --incdir=$INC_DIR \
    --libdir=$LIB_DIR/$CPU \
    --enable-cross-compile \
    --extra-libs="-lgcc" \
    --arch=$ARCH \
    --cc=$PREBUILT/bin/$HOST-gcc \
    --ranlib=$PREBUILT/bin/$HOST-ranlib \
    --cross-prefix=$PREBUILT/bin/$HOST- \
    --nm=$PREBUILT/bin/$HOST-nm \
    --sysroot=$PLATFORM \
    --extra-cflags="-isysroot $ANDROID_SYSROOT $ADDITIONAL_CFLAGS -fvisibility=hidden -fdata-sections -ffunction-sections -Os -fPIC -DANDROID -DHAVE_SYS_UIO_H=1 -Dipv6mr_interface=ipv6mr_ifindex -fasm -Wno-psabi -fno-short-enums -fno-strict-aliasing -finline-limit=300" \
    --extra-ldflags="-Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib -lc -lm -ldl -llog" \
    --disable-everything \
    --disable-x86asm \
    --disable-avfilter \
    --disable-avdevice \
    --disable-programs \
    --disable-ffmpeg \
    --disable-ffplay \
    --disable-ffprobe \
    --disable-avfilter \
    --disable-avdevice \
    --disable-postproc \
    --disable-shared \
    --enable-static \
    --enable-gpl \
    --enable-small \
    --enable-runtime-cpudetect \
    --enable-avformat \
    --enable-avcodec \
    --enable-avutil \
    --enable-swresample \
    --enable-swscale \
    --disable-decoders \
    --enable-decoder=aac \
    --enable-decoder=flv \
    --enable-decoder=h264 \
    --enable-decoder=mpeg4 \
    --enable-demuxers \
    --enable-parsers \
    --enable-network \
    --disable-openssl \
    --disable-protocol=https \
    --enable-protocol=file \
    --enable-protocol=http \
    --enable-protocol=rtmp \
    $ADDITIONAL_CONFIGURE_FLAG

make clean
make -j8 install V=1
popd
}

#armeabi
CPU=armeabi
ARCH=arm
ADDITIONAL_CFLAGS="-marm -march=armv5 -I$ANDROID_SYSROOT/usr/include/arm-linux-androideabi"
ADDITIONAL_CONFIGURE_FLAG=--enable-neon
build_one

#armeabi-v7a
CPU=armeabi-v7a
ARCH=arm
ADDITIONAL_CFLAGS="-marm -march=armv7-a -mtune=cortex-a8 -mfloat-abi=softfp -mfpu=neon -I$ANDROID_SYSROOT/usr/include/arm-linux-androideabi"
ADDITIONAL_CONFIGURE_FLAG=--enable-neon
build_one

#arm64-v8a
CPU=arm64-v8a
ARCH=arm64
ADDITIONAL_CFLAGS="-I$ANDROID_SYSROOT/usr/include/aarch64-linux-android"
ADDITIONAL_CONFIGURE_FLAG=
build_one

# x86
CPU=x86
ARCH=x86
ADDITIONAL_CFLAGS="-fomit-frame-pointer -I$ANDROID_SYSROOT/usr/include/i686-linux-android"
ADDITIONAL_CONFIGURE_FLAG=
build_one

# x86_64
# CPU=x86_64
# ARCH=x86_64
# ADDITIONAL_CFLAGS="-fomit-frame-pointer $ANDROID_SYSROOT/usr/include/x86_64-linux-android"
# ADDITIONAL_CONFIGURE_FLAG=
# build_one


#!/bin/bash
LOCAL_PATH=`pwd`
INC_DIR=$LOCAL_PATH/ffmpeg/release/unix/inc
LIB_DIR=$LOCAL_PATH/ffmpeg/release/unix/libs

if [ ! -d "./ffmpeg" ]; then
    git clone git@github.com:FFmpeg/FFmpeg ffmpeg
fi

cd ffmpeg
rm -rf config.h
rm -rf release/unix
mkdir -p release/unix

./configure --enable-version3 \
    --incdir=$INC_DIR \
    --libdir=$LIB_DIR \
    --disable-everything \
    --disable-x86asm \
    --disable-opencl \
    --disable-libopencv \
    --disable-iconv \
    --disable-lzma  \
    --disable-nonfree \
    --disable-hwaccels \
    --disable-videotoolbox \
    --disable-audiotoolbox \
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
    --enable-decoder=hevc \
    --enable-decoder=mpeg4 \
    --enable-demuxers \
    --enable-parsers \
    --enable-network \
    --disable-openssl \
    --disable-protocol=https \
    --enable-protocol=file \
    --enable-protocol=http \
    --enable-protocol=rtmp

make clean
make -j8 install V=1



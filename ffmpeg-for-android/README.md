# How to build ffmpeg for Android

#### 1. Download the ffmpeg source code

```
$git clone git@github.com:FFmpeg/FFmpeg ffmpeg
```

#### 2. Copy build_for_android.sh to `ffmpeg` dir

```
$cp build_for_android.sh ffmpeg
```

#### 3. Export `ANDROID_NDK`

```
$export ANDROID_NDK=/Users/Jhuster/Library/Android/android-ndk-r10e
```

#### 4. Run build scripts

```
$cd ffmpeg
$./build_for_android.sh
```

#### 5. Acknowledge

Thanks for `https://trac.ffmpeg.org/attachment/ticket/4928/build_ffmpeg.sh`


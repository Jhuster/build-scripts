# How to build x264 for Android

#### 1. Download the x264 source code

```
$git clone http://git.videolan.org/git/x264.git
```

#### 2. Copy build-for-android.sh to `x264` dir

```
$cp build-for-android.sh x264
```

#### 3. Export `ANDROID_NDK`

```
$export ANDROID_NDK=/Users/Jhuster/Library/Android/android-ndk-r10e
```

#### 4. Run build scripts

```
$cd x264
$./build-for-android.sh
```

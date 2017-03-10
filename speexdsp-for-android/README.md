# How to build speexdsp for Android

#### 1. Download the speexdsp source code

```
$git clone git@github.com:xiph/speexdsp speexdsp
```

#### 2. Copy `Android.mk` and `make-for-android.sh` to `speexdsp` dir

```
$cp Android.mk speexdsp/
$cp make-for-android.sh speexdsp/
```

#### 3. Run build scripts

```
$cd speexdsp
$./make-for-android.sh
```


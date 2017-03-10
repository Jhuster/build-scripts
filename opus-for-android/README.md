# How to build opus for Android

#### 1. Download and uzip the opus source code

```
$wget http://downloads.xiph.org/releases/opus/opus-1.1.4.tar.gz
$tar zxvf opus-1.1.4.tar.gz
```

#### 2. Copy `Android.mk` and `make-for-android.sh` to `opus-1.1.4` dir

```
$cp Android.mk opus-1.1.4/
$cp make-for-android.sh opus-1.1.4/
```

#### 3. Run build scripts

```
$cd opus-1.1.4
$./make-for-android.sh
```


LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := opus
LOCAL_SRC_FILES := \
    $(subst $(LOCAL_PATH)/,,$(wildcard $(LOCAL_PATH)/src/*.c)) \
    $(subst $(LOCAL_PATH)/,,$(wildcard $(LOCAL_PATH)/celt/*.c)) \
    $(subst $(LOCAL_PATH)/,,$(wildcard $(LOCAL_PATH)/silk/*.c)) \
    $(subst $(LOCAL_PATH)/,,$(wildcard $(LOCAL_PATH)/silk/fixed/*.c))

LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/include \
    $(LOCAL_PATH)/silk \
    $(LOCAL_PATH)/silk/fixed \
    $(LOCAL_PATH)/celt
LOCAL_CFLAGS := -DNULL=0 -DSOCKLEN_T=socklen_t -DLOCALE_NOT_USED -D_LARGEFILE_SOURCE=1 -D_FILE_OFFSET_BITS=64 -fPIC
LOCAL_CFLAGS += -Drestrict='' -D__EMX__ -DOPUS_BUILD -DFIXED_POINT -DUSE_ALLOCA -DHAVE_LRINT -DHAVE_LRINTF -O3 -fno-math-errno
LOCAL_CPPFLAGS := -DBSD=1 
LOCAL_CPPFLAGS += -ffast-math -O3 -funroll-loops

include $(BUILD_STATIC_LIBRARY)

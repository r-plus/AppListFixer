ARCHS = arm64 arm64e
TARGET = iphone:clang::13.0
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = AppListFixer
AppListFixer_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"

export ARCHS = armv7 arm64
export TARGET = iphone:clang:10.2:latest
FINALPACKAGE = 1
DEBUG = 0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Revelio
Revelio_FILES = RevelioHooks.xm
Revelio_FRAMEWORKS = UIKit Foundation CoreFoundation CoreGraphics QuartzCore

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += Revelio
include $(THEOS_MAKE_PATH)/aggregate.mk

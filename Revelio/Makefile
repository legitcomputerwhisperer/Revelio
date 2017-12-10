include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = Revelio
Revelio_CFLAGS = -fobjc-arc
Revelio_FILES = RevelioListController.xm RevelioRespringButton.xm
Revelio_INSTALL_PATH = /Library/PreferenceBundles
Revelio_FRAMEWORKS = UIKit Foundation CoreFoundation CoreGraphics QuartzCore
Revelio_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/Revelio.plist$(ECHO_END)

ARCHS = armv7 arm64

include theos/makefiles/common.mk

BUNDLE_NAME = GroupQuiet
GroupQuiet_FILES = $(wildcard *.m)
GroupQuiet_INSTALL_PATH = /Library/PreferenceBundles
GroupQuiet_FRAMEWORKS = UIKit
GroupQuiet_PRIVATE_FRAMEWORKS = Preferences
GroupQuiet_LIBRARIES = hbangprefs

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/GroupQuiet.plist$(ECHO_END)

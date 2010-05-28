LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := scriptybox
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

SCRIPTYBOX_LINKS := $(shell cat $(LOCAL_PATH)/scriptybox.links)

# used to exclude anything
exclude := 

SYMLINKS := $(addprefix $(TARGET_OUT_OPTIONAL_EXECUTABLES)/,$(filter-out $(exclude),$(notdir $(SCRIPTYBOX_LINKS))))
$(SYMLINKS): SCRIPTYBOX_SCRIPT := $(LOCAL_MODULE)
$(SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Symlink: $@ -> $(SCRIPTYBOX_SCRIPT)"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf $(SCRIPTYBOX_SCRIPT) $@

ALL_DEFAULT_INSTALLED_MODULES += $(SYMLINKS)

# We need this so that the installed files could be picked up based on the
# local module name
ALL_MODULES.$(LOCAL_MODULE).INSTALLED := \
    $(ALL_MODULES.$(LOCAL_MODULE).INSTALLED) $(SYMLINKS)


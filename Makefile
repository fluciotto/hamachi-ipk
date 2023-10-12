include $(TOPDIR)/rules.mk

# Name and release number of this package
PKG_NAME:=hamachi
PKG_VERSION:=2.1.0.203
PKG_RELEASE:=1

# This specifies the directory where we're going to build the program.
# The root build directory, $(BUILD_DIR), is by default the build_mipsel
# directory in your OpenWrt SDK directory
PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

# Disable executable stripping
RSTRIP:=:


# Specify package information for this program.
# The variables defined here should be self explanatory.

define Package/hamachi
	SUBMENU:=VPN
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Hamachi
endef

define Build/Prepare
	$(CP) * $(PKG_BUILD_DIR)/
endef


define Build/Compile
	cd $(PKG_BUILD_DIR) && ./run.sh
endef


define Package/hamachi/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_BUILD_DIR)/work/hamachid.static $(1)/usr/bin/hamachid
	$(CP) $(PKG_BUILD_DIR)/work/hamachi.static $(1)/usr/bin/hamachi
	$(CP) files/* $(1)
endef


# This line executes the necessary commands to compile our program.
# The above define directives specify all the information needed, but this
# line calls BuildPackage which in turn actually uses this information to
# build a package.
$(eval $(call BuildPackage,hamachi))

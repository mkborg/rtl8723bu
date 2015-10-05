EXTRA_CFLAGS += $(USER_EXTRA_CFLAGS)
EXTRA_CFLAGS += -O1
#EXTRA_CFLAGS += -O3
#EXTRA_CFLAGS += -Wall
#EXTRA_CFLAGS += -Wextra
#EXTRA_CFLAGS += -Werror
#EXTRA_CFLAGS += -pedantic
#EXTRA_CFLAGS += -Wshadow -Wpointer-arith -Wcast-qual -Wstrict-prototypes -Wmissing-prototypes

EXTRA_CFLAGS += -Wno-unused-variable
EXTRA_CFLAGS += -Wno-unused-value
EXTRA_CFLAGS += -Wno-unused-label
EXTRA_CFLAGS += -Wno-unused-parameter
EXTRA_CFLAGS += -Wno-unused-function
EXTRA_CFLAGS += -Wno-unused

#EXTRA_CFLAGS += -Wno-uninitialized

EXTRA_CFLAGS += -I$(src)/include

EXTRA_LDFLAGS += --strip-debug

########################## WIFI IC ############################
CONFIG_RTL8723B = y
######################### Interface ###########################
CONFIG_USB_HCI = y
########################## Features ###########################
CONFIG_MP_INCLUDED = y
CONFIG_POWER_SAVING = y
CONFIG_USB_AUTOSUSPEND = n
CONFIG_HW_PWRP_DETECTION = n
CONFIG_WIFI_TEST = n
CONFIG_BT_COEXIST = y
CONFIG_INTEL_WIDI = n
CONFIG_WAPI_SUPPORT = n
CONFIG_EFUSE_CONFIG_FILE = n
CONFIG_EXT_CLK = n
CONFIG_TRAFFIC_PROTECT = y
CONFIG_LOAD_PHY_PARA_FROM_FILE = y
CONFIG_CALIBRATE_TX_POWER_BY_REGULATORY = n
CONFIG_CALIBRATE_TX_POWER_TO_MAX = n
CONFIG_RTW_ADAPTIVITY_EN = auto
CONFIG_RTW_ADAPTIVITY_MODE = normal
CONFIG_SKIP_SIGNAL_SCALE_MAPPING = n
######################## Wake On Lan ##########################
CONFIG_WOWLAN = n
CONFIG_GPIO_WAKEUP = n
CONFIG_PNO_SUPPORT = n
CONFIG_PNO_SET_DEBUG = n
CONFIG_AP_WOWLAN = n
###################### Platform Related #######################
CONFIG_PLATFORM_I386_PC = n
CONFIG_PLATFORM_ARM_OLIMEX_AIRLOCK = y
###############################################################

CONFIG_DRVEXT_MODULE = n

export TopDIR ?= $(shell pwd)

########### COMMON  #################################


_OS_INTFS_FILES :=	os_dep/osdep_service.o \
			os_dep/os_intfs.o \
			os_dep/usb_intf.o \
			os_dep/usb_ops_linux.o \
			os_dep/ioctl_linux.o \
			os_dep/xmit_linux.o \
			os_dep/mlme_linux.o \
			os_dep/recv_linux.o \
			os_dep/ioctl_cfg80211.o \
			os_dep/wifi_regd.o \
			os_dep/rtw_android.o \
			os_dep/rtw_proc.o

_HAL_INTFS_FILES :=	hal/hal_intf.o \
			hal/hal_com.o \
			hal/hal_com_phycfg.o \
			hal/hal_phy.o \
			hal/hal_btcoex.o \
			hal/hal_usb.o \
			hal/hal_usb_led.o
			
_OUTSRC_FILES := hal/odm_debug.o	\
		hal/odm_AntDiv.o\
		hal/odm_interface.o\
		hal/odm_HWConfig.o\
		hal/odm.o\
		hal/HalPhyRf.o\
		hal/odm_EdcaTurboCheck.o\
		hal/odm_DIG.o\
		hal/odm_PathDiv.o\
		hal/odm_RaInfo.o\
		hal/odm_DynamicBBPowerSaving.o\
		hal/odm_DynamicTxPower.o\
		hal/odm_CfoTracking.o\
		hal/odm_NoiseMonitor.o
		
EXTRA_CFLAGS += -I$(src)/platform
_PLATFORM_FILES := platform/platform_ops.o

ifeq ($(CONFIG_BT_COEXIST), y)
EXTRA_CFLAGS += -I$(src)/hal
_OUTSRC_FILES += hal/HalBtc8723b1Ant.o
_OUTSRC_FILES += hal/HalBtc8723b2Ant.o
endif

########### HAL_RTL8723B #################################

MODULE_NAME = rtl8723bu

EXTRA_CFLAGS += -DCONFIG_RTL8723B

_HAL_INTFS_FILES += hal/HalPwrSeqCmd.o \
					hal/Hal8723BPwrSeq.o\
					hal/rtl8723b_sreset.o

_HAL_INTFS_FILES +=	hal/rtl8723b_hal_init.o \
			hal/rtl8723b_phycfg.o \
			hal/rtl8723b_rf6052.o \
			hal/rtl8723b_dm.o \
			hal/rtl8723b_rxdesc.o \
			hal/rtl8723b_cmd.o \
			

_HAL_INTFS_FILES +=	\
			hal/usb_halinit.o \
			hal/rtl8723bu_led.o \
			hal/rtl8723bu_xmit.o \
			hal/rtl8723bu_recv.o

_HAL_INTFS_FILES += hal/usb_ops.o

ifeq ($(CONFIG_MP_INCLUDED), y)
_HAL_INTFS_FILES += hal/rtl8723b_mp.o
endif

_OUTSRC_FILES += hal/HalHWImg8723B_BB.o\
			hal/HalHWImg8723B_MAC.o\
			hal/HalHWImg8723B_RF.o\
			hal/HalHWImg8723B_FW.o\
			hal/HalHWImg8723B_MP.o\
			hal/odm_RegConfig8723B.o\
			hal/HalPhyRf_8723B.o\
			hal/odm_RTL8723B.o


########### END OF PATH  #################################


ifeq ($(CONFIG_USB_AUTOSUSPEND), y)
EXTRA_CFLAGS += -DCONFIG_USB_AUTOSUSPEND
endif

ifeq ($(CONFIG_MP_INCLUDED), y)
EXTRA_CFLAGS += -DCONFIG_MP_INCLUDED
endif

ifeq ($(CONFIG_POWER_SAVING), y)
EXTRA_CFLAGS += -DCONFIG_POWER_SAVING
endif

ifeq ($(CONFIG_HW_PWRP_DETECTION), y)
EXTRA_CFLAGS += -DCONFIG_HW_PWRP_DETECTION
endif

ifeq ($(CONFIG_WIFI_TEST), y)
EXTRA_CFLAGS += -DCONFIG_WIFI_TEST
endif

ifeq ($(CONFIG_BT_COEXIST), y)
EXTRA_CFLAGS += -DCONFIG_BT_COEXIST
endif

ifeq ($(CONFIG_INTEL_WIDI), y)
EXTRA_CFLAGS += -DCONFIG_INTEL_WIDI
endif

ifeq ($(CONFIG_WAPI_SUPPORT), y)
EXTRA_CFLAGS += -DCONFIG_WAPI_SUPPORT
endif


ifeq ($(CONFIG_EFUSE_CONFIG_FILE), y)
EXTRA_CFLAGS += -DCONFIG_EFUSE_CONFIG_FILE
ifeq ($(MODULE_NAME), 8189es)
EXTRA_CFLAGS += -DEFUSE_MAP_PATH=\"/system/etc/wifi/wifi_efuse_8189e.map\"
else
EXTRA_CFLAGS += -DEFUSE_MAP_PATH=\"/system/etc/wifi/wifi_efuse_$(MODULE_NAME).map\"
endif
EXTRA_CFLAGS += -DWIFIMAC_PATH=\"/data/wifimac.txt\"
endif

ifeq ($(CONFIG_EXT_CLK), y)
EXTRA_CFLAGS += -DCONFIG_EXT_CLK
endif

ifeq ($(CONFIG_TRAFFIC_PROTECT), y)
EXTRA_CFLAGS += -DCONFIG_TRAFFIC_PROTECT
endif

ifeq ($(CONFIG_LOAD_PHY_PARA_FROM_FILE), y)
EXTRA_CFLAGS += -DCONFIG_LOAD_PHY_PARA_FROM_FILE
endif

ifeq ($(CONFIG_CALIBRATE_TX_POWER_BY_REGULATORY), y)
EXTRA_CFLAGS += -DCONFIG_CALIBRATE_TX_POWER_BY_REGULATORY
endif

ifeq ($(CONFIG_CALIBRATE_TX_POWER_TO_MAX), y)
EXTRA_CFLAGS += -DCONFIG_CALIBRATE_TX_POWER_TO_MAX
endif

ifeq ($(CONFIG_RTW_ADAPTIVITY_EN), disable)
EXTRA_CFLAGS += -DCONFIG_RTW_ADAPTIVITY_EN=0
else ifeq ($(CONFIG_RTW_ADAPTIVITY_EN), enable)
EXTRA_CFLAGS += -DCONFIG_RTW_ADAPTIVITY_EN=1
else ifeq ($(CONFIG_RTW_ADAPTIVITY_EN), auto)
EXTRA_CFLAGS += -DCONFIG_RTW_ADAPTIVITY_EN=2
endif

ifeq ($(CONFIG_RTW_ADAPTIVITY_MODE), normal)
EXTRA_CFLAGS += -DCONFIG_RTW_ADAPTIVITY_MODE=0
else ifeq ($(CONFIG_RTW_ADAPTIVITY_MODE), carrier_sense)
EXTRA_CFLAGS += -DCONFIG_RTW_ADAPTIVITY_MODE=1
endif

ifeq ($(CONFIG_SKIP_SIGNAL_SCALE_MAPPING), y)
EXTRA_CFLAGS += -DCONFIG_SKIP_SIGNAL_SCALE_MAPPING
endif

ifeq ($(CONFIG_WOWLAN), y)
EXTRA_CFLAGS += -DCONFIG_WOWLAN
endif

ifeq ($(CONFIG_AP_WOWLAN), y)
EXTRA_CFLAGS += -DCONFIG_AP_WOWLAN
endif

ifeq ($(CONFIG_PNO_SUPPORT), y)
EXTRA_CFLAGS += -DCONFIG_PNO_SUPPORT
ifeq ($(CONFIG_PNO_SET_DEBUG), y)
EXTRA_CFLAGS += -DCONFIG_PNO_SET_DEBUG
endif
endif

ifeq ($(CONFIG_GPIO_WAKEUP), y)
EXTRA_CFLAGS += -DCONFIG_GPIO_WAKEUP
endif


ifeq ($(CONFIG_PLATFORM_I386_PC), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN
#EXTRA_CFLAGS += -DCONFIG_CONCURRENT_MODE
EXTRA_CFLAGS += -DCONFIG_IOCTL_CFG80211
EXTRA_CFLAGS += -DRTW_USE_CFG80211_STA_EVENT # only enable when kernel >= 3.2
EXTRA_CFLAGS += -DCONFIG_P2P_IPS
SUBARCH := $(shell uname -m | sed -e s/i.86/i386/)
ARCH ?= $(SUBARCH)
CROSS_COMPILE ?=
KVER  := $(shell uname -r)
KSRC := /lib/modules/$(KVER)/build
MODDESTDIR := /lib/modules/$(KVER)/kernel/drivers/net/wireless/
INSTALL_PREFIX :=
endif


ifeq ($(CONFIG_PLATFORM_ARM_OLIMEX_AIRLOCK), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN
EXTRA_CFLAGS += -DCONFIG_IOCTL_CFG80211
EXTRA_CFLAGS += -DRTW_USE_CFG80211_STA_EVENT # only enable when kernel >= 3.2
EXTRA_CFLAGS += -DCONFIG_P2P_IPS
endif


ifneq ($(USER_MODULE_NAME),)
MODULE_NAME := $(USER_MODULE_NAME)
endif


rtk_core :=	core/rtw_cmd.o \
		core/rtw_security.o \
		core/rtw_debug.o \
		core/rtw_io.o \
		core/rtw_ioctl_query.o \
		core/rtw_ioctl_set.o \
		core/rtw_ieee80211.o \
		core/rtw_mlme.o \
		core/rtw_mlme_ext.o \
		core/rtw_wlan_util.o \
		core/rtw_vht.o \
		core/rtw_pwrctrl.o \
		core/rtw_rf.o \
		core/rtw_recv.o \
		core/rtw_sta_mgt.o \
		core/rtw_ap.o \
		core/rtw_xmit.o	\
		core/rtw_p2p.o \
		core/rtw_tdls.o \
		core/rtw_br_ext.o \
		core/rtw_iol.o \
		core/rtw_sreset.o \
		core/rtw_btcoex.o \
		core/rtw_beamforming.o \
		core/rtw_odm.o \
		core/rtw_efuse.o

$(MODULE_NAME)-y += $(rtk_core)

$(MODULE_NAME)-$(CONFIG_INTEL_WIDI) += core/rtw_intel_widi.o

$(MODULE_NAME)-$(CONFIG_WAPI_SUPPORT) += core/rtw_wapi.o	\
					core/rtw_wapi_sms4.o
					
$(MODULE_NAME)-y += $(_OS_INTFS_FILES)
$(MODULE_NAME)-y += $(_HAL_INTFS_FILES)
$(MODULE_NAME)-y += $(_OUTSRC_FILES)
$(MODULE_NAME)-y += $(_PLATFORM_FILES)

$(MODULE_NAME)-$(CONFIG_MP_INCLUDED) += core/rtw_mp.o \
					core/rtw_mp_ioctl.o

$(MODULE_NAME)-$(CONFIG_MP_INCLUDED)+= core/rtw_bt_mp.o

CONFIG_RTL8723BU = m
obj-$(CONFIG_RTL8723BU) := $(MODULE_NAME).o


all: modules

modules:
	$(MAKE) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C $(KSRC) M=$(shell pwd)  modules

strip:
	$(CROSS_COMPILE)strip $(MODULE_NAME).ko --strip-unneeded

install:
	install -p -m 644 $(MODULE_NAME).ko  $(MODDESTDIR)
	/sbin/depmod -a ${KVER}

uninstall:
	rm -f $(MODDESTDIR)/$(MODULE_NAME).ko
	/sbin/depmod -a ${KVER}


.PHONY: modules clean

clean:
	cd hal ; rm -fr */*.mod.c */*.mod */*.o */.*.cmd */*.ko
	cd core ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko
	cd os_dep ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko
	cd platform ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko
	rm -fr Module.symvers ; rm -fr Module.markers ; rm -fr modules.order
	rm -fr *.mod.c *.mod *.o .*.cmd *.ko *~
	rm -fr .tmp_versions

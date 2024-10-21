#
# Copyright (c) 2014 The Android Open-Source Project
# Copyright (c) 2024 StatiXOS
#
# SPDX-License-Identifier: Apache-2.0
#

COMMON_PATH := device/xiaomi/sm8650-common

# Use the non-open-source parts, if they're present
-include vendor/xiaomi/sm8650-common/BoardConfigVendor.mk

# A/B
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    init_boot \
    odm \
    product \
    recovery \
    system \
    system_dlkm \
    system_ext \
    vbmeta \
    vendor \
    vendor_boot \
    vendor_dlkm

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := pineapple
TARGET_NO_BOOTLOADER := true

# Kernel
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)

BOARD_PREBUILT_DTBIMAGE_DIR := $(TARGET_KERNEL_DIR)
BOARD_PREBUILT_DTBOIMAGE := $(BOARD_PREBUILT_DTBIMAGE_DIR)/dtbo.img

BOARD_KERNEL_CMDLINE := \
    video=vfb:640x400,bpp=32,memsize=3072000

BOARD_BOOTCONFIG := \
    androidboot.hardware=qcom \
    androidboot.memcg=1 \
    androidboot.usbcontroller=a600000.dwc3 \
    androidboot.load_modules_parallel=true

BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_TAGS_OFFSET := 0x01E00000
BOARD_RAMDISK_OFFSET := 0x02000000

BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)

BOARD_INIT_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_INIT_ARGS += --header_version $(BOARD_INIT_BOOT_HEADER_VERSION)

BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true
BOARD_USES_GENERIC_KERNEL_IMAGE := true
TARGET_HAS_GENERIC_KERNEL_HEADERS := true

# Kernel Modules
BOARD_BUILD_VENDOR_RAMDISK_IMAGE := true

KERNEL_MODULE_DIR := $(TARGET_KERNEL_DIR)
KERNEL_MODULES := $(wildcard $(KERNEL_MODULE_DIR)/*.ko)

BOARD_VENDOR_KERNEL_MODULES_BLOCKLIST_FILE := $(KERNEL_MODULE_DIR)/modules.blocklist

BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat $(KERNEL_MODULE_DIR)/vendor_boot.modules.load))
ifndef BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD
$(error vendor_boot.modules.load not found or empty)
endif
BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(addprefix $(KERNEL_MODULE_DIR)/, $(notdir $(BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD)))

BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(KERNEL_MODULE_DIR)/modules.load))
ifndef BOARD_VENDOR_KERNEL_MODULES_LOAD
$(error vendor_dlkm.modules.load not found or empty)
endif

BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(addprefix $(KERNEL_MODULE_DIR)/, $(notdir $(BOARD_VENDOR_KERNEL_MODULES_LOAD)))
BOARD_VENDOR_KERNEL_MODULES := $(KERNEL_MODULES)

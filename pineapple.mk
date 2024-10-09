#
# Copyright (c) 2014 The Android Open-Source Project
# Copyright (c) 2024 StatiXOS
#
# SPDX-License-Identifier: Apache-2.0
#

$(call inherit-product-if-exists, vendor/xiaomi/sm8650-common/sm8650-common-vendor.mk)

# Board
TARGET_BOARD_PLATFORM := pineapple
PRODUCT_USES_QCOM_HARDWARE := true
PRODUCT_BOARD_PLATFORM := $(TARGET_BOARD_PLATFORM)

# A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/vabc_features.mk)

# Boot Control
PRODUCT_PACKAGES += \
    android.hardware.boot-service.qti \
    android.hardware.boot-service.qti.recovery

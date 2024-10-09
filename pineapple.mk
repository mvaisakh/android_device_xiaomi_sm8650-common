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

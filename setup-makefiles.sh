#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2021 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -e

export DEVICE=mt6893-common
export VENDOR=oplus

INITIAL_COPYRIGHT_YEAR=2021

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils-old/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

function vendor_imports() {
	cat <<EOF >>"$1"
		"device/oplus/mt6893-common",
		"hardware/mediatek",
		"hardware/mediatek/libmtkperf_client"
EOF
}

# Initialize the helper for device
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false

# Copyright headers and guards
write_headers "mt6893"

# The standard blobs
write_makefiles "${MY_DIR}/proprietary-files.txt" true

# Finish
write_footers

#!/bin/bash

BASE_BSP=$(pwd)/Linux_for_Tegra
KERNEL_OUT=${BASE_BSP}/source/kernel_out
KERNEL_OOT_OUT=${BASE_BSP}/source/kernel_oot_out


echo "Checking build objects."

compare_ko_modules() {
    local KERNEL_OUT_DIR="$1"
    local DEB_DIR="$2"

    # Check if directory exist
    if [ ! -d "$KERNEL_OUT_DIR" ] || [ ! -d "$DEB_DIR" ]; then
        echo "Error: Directory ${KERNEL_OUT_DIR} or ${DEB_DIR} doesn't exist."
        return 1
    fi

    shopt -s globstar nullglob  # enable recusive mathching

    for file in $(find "$KERNEL_OUT_DIR" -name "*.ko" -printf "%f\n"); do
        local MY_FILE MATCH_FILE
        MY_FILE=$(find "$KERNEL_OUT_DIR" -name "$file" | head -n 1)
        MATCH_FILE=$(find "$DEB_DIR" -name "$file" | head -n 1)

        if [ -n "$MATCH_FILE" ]; then
            # 先复制临时文件再 strip，避免改动原始文件
            local TMP_MY=$(mktemp)
            local TMP_DEB=$(mktemp)
            cp "$MY_FILE" "$TMP_MY"
            cp "$MATCH_FILE" "$TMP_DEB"

            strip --strip-debug "$TMP_MY"
            strip --strip-debug "$TMP_DEB"

            if ! cmp -s "$TMP_MY" "$TMP_DEB"; then
                echo "Different: $file"
            fi

            rm -f "$TMP_MY" "$TMP_DEB"
        fi
    done
}


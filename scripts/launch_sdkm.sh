#!/bin/bash

set -e

echo "Clean the previous download cache..."

rm -rvf ~/.nvsdkm/hwdata
rm -rvf ~/.nvsdkm/dist

echo "Start SDK Manager"

sdkmanager --hw-server http://seeed-projects.github.io/SeeedSDKM/seeed-hwdata/sdkml1_repo_hw.json --server http://seeed-projects.github.io/SeeedSDKM/seeed-dist/main/sdkml1_repo.json
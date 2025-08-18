#!/bin/bash

set -e

echo "Clean the previous download cache..."

rm -rvf ~/.nvsdkm/hwdata
rm -rvf ~/.nvsdkm/dist

echo "Start SDK Manager"

sdkmanager --hw-server http://127.0.0.1:8000/seeed-hwdata/sdkml1_repo_hw.json --server http://127.0.0.1:8000/seeed-dist/main/sdkml1_repo.json
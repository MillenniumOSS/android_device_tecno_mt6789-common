#!/bin/bash

RET=0
echo "- Applying fenrir compatiblity patches"
cd system/fs/fs_mgr
curl https://raw.githubusercontent.com/MillenniumOSS/patches/refs/heads/seventeen-yaap/system/fs/fs_mgr/0001-libfs_avb-Allow-LKs-patched-with-fenrir-to-boot-on-A.patch | git am || {
  RET=1
  git am --abort >/dev/null 2>&1
}

cd ../../../
cd system/core
curl https://raw.githubusercontent.com/MillenniumOSS/patches/refs/heads/sixteen-yaap/system/core/0002-fastbootd-Always-return-false-for-GetDeviceLockStatu.patch | git am || {
  RET=1
  git am --abort >/dev/null 2>&1
}
cd ../../

echo "- Applying perf anim override patch"
cd frameworks/base
curl https://raw.githubusercontent.com/MillenniumOSS/patches/refs/heads/seventeen-yaap/frameworks/base/0001-bugfix-add-perf-activity-anim-override.patch | git am || {
  RET=1
  git am --abort >/dev/null 2>&1
}
cd ../../
cd vendor/yaap
curl https://raw.githubusercontent.com/MillenniumOSS/patches/refs/heads/sixteen-yaap/vendor/yaap/0001-PATCH-add-PERF_ANIM_OVERRIDE-flag.patch | git am || {
  RET=1
  git am --abort >/dev/null 2>&1
}
cd ../../

if [ $RET -ne 0 ]; then
  echo "ERROR: Patch is not applied! Maybe it's already patched, or you'll have to adapt it to this specific rom source?"
else
  echo "OK: All patched"
fi

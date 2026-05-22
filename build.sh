#!/bin/bash
# build.sh - 打包 Magisk 模块

# 清理 Mac 垃圾文件
find . -name ".DS_Store" -delete

# 打包
zip -r ./Magisk-MoveCACerts.zip . \
  -x "cert2android.sh" \
  -x "build.sh" \
  -x "system/etc/security/cacerts/placeholder" \
  -x ".git/*" \
  -x ".gitignore" \
  -x ".gitattributes" \
  -x ".DS_Store" \
  -x "*/.DS_Store" \
  -x "__MACOSX/*" \
  -x "*.md"

echo "✅ 打包完成: Magisk-MoveCACerts.zip"
echo "推送到手机进行安装: adb push Magisk-MoveCACerts.zip /sdcard/Download"

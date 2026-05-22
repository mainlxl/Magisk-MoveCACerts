#!/bin/bash
# cert2android.sh - 将 PEM/DER 证书转换为 Android 系统证书格式
# 用法: ./cert2android.sh <证书文件>

set -e

INPUT_FILE="$1"

if [ -z "$INPUT_FILE" ] || [ ! -f "$INPUT_FILE" ]; then
    echo "用法: $0 <证书文件>"
    exit 1
fi

# 自动检测格式
if grep -q "BEGIN CERTIFICATE" "$INPUT_FILE" 2>/dev/null; then
    FORMAT="PEM"
else
    FORMAT="DER"
fi

# OpenSSL 1.0+ 用 -subject_hash_old，旧版用 -subject_hash
OPENSSL_VERSION=$(openssl version | awk '{print $2}' | cut -d. -f1)
HASH_OPT=$([ "$OPENSSL_VERSION" -ge 1 ] && echo "-subject_hash_old" || echo "-subject_hash")

# 计算 hash
HASH=$(openssl x509 -inform $FORMAT $HASH_OPT -in "$INPUT_FILE" -noout)
OUTPUT_FILE="${HASH}.0"

# 转换为 DER
if [ "$FORMAT" = "PEM" ]; then
    openssl x509 -in "$INPUT_FILE" -inform PEM -outform DER -out "$OUTPUT_FILE"
else
    cp "$INPUT_FILE" "$OUTPUT_FILE"
fi

mv $OUTPUT_FILE system/etc/security/cacerts/
echo "✅ 生成证书: $OUTPUT_FILE"

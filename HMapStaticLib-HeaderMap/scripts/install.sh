#!/bin/bash

# 检查脚本权限并自动添加
[ ! -x "$0" ] && chmod +x "$0"

echo '🍺 ～～ 开始处理静态库产物 🕙 ... '

# 定义变量
SDK_PATH="${BUILD_DIR}/${CONFIGURATION}-${PLATFORM_NAME}"
SDK_NAME="${PRODUCT_NAME}"
SRC_HEADER_DIR="usr/local/include"  # public 头文件位置
DST_HEADER_DIR="${SDK_NAME}/Headers"  # 目标头文件目录
DST_LIB_DIR="${SDK_NAME}"             # 目标库文件目录

# 验证SDK路径
if [ ! -d "$SDK_PATH" ]; then
    echo "错误: 静态库路径不存在 - ${SDK_PATH}"
    exit 1
fi

# 进入SDK目录
cd "$SDK_PATH" || { echo "无法进入静态库目录"; exit 1; }

# 创建目标目录结构
mkdir -p "$DST_HEADER_DIR" || { echo "无法创建目标头文件目录"; exit 1; }

# 复制库文件
if [ -f "lib${SDK_NAME}.a" ]; then
    cp "lib${SDK_NAME}.a" "$DST_LIB_DIR/" || { echo "复制库文件失败"; exit 1; }
    echo "✅ 已复制库文件: lib${SDK_NAME}.a"
else
    echo "警告: 库文件不存在 - lib${SDK_NAME}.a"
fi

# 复制头文件（递归复制整个目录结构）
if [ -d "${SRC_HEADER_DIR}" ]; then
    # 递归复制所有内容（包括子目录和隐藏文件）
    cp -R "${SRC_HEADER_DIR}/." "$DST_HEADER_DIR" || {
        echo "复制头文件失败"
        exit 1
    }
    
    # 计算复制的文件数量
    COUNT=$(find "$DST_HEADER_DIR" -type f | wc -l | tr -d ' ')
    echo "✅ 已复制头文件: $COUNT 个文件（包含目录结构）"
else
    echo "警告: 头文件源目录不存在或为空 - $SRC_HEADER_DIR"
fi

# 输出最终结果
echo "🎉 ～～ 静态库产物处理完成 🍺🍺🍺"
echo "产物路径: ${SDK_PATH}/${SDK_NAME}"

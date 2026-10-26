#!/bin/bash
set -e # Останавливать скрипт при любой ошибке

# =====================================================================
# НАСТРОЙКА ПУТЕЙ (Укажите ваши актуальные пути)
# =====================================================================
export ANDROID_SDK_ROOT="/home/user/Android/Sdk"
export ANDROID_NDK_ROOT="$ANDROID_SDK_ROOT/ndk/26.1.10909125"
export QT_ANDROID_PATH="/home/user/Qt/6.8.0/android_arm64_v8a"

TARGET_ABI="arm64-v8a"     # Архитектура: arm64-v8a, armeabi-v7a, x86_64
ANDROID_API_LEVEL="34"    # Целевая версия Android API
BUILD_DIR="build_android"
# =====================================================================

echo "=== [1/3] Конфигурация проекта (CMake -> Ninja) ==="
# Утилита qt-cmake автоматически настраивает Clang из Android NDK
$QT_ANDROID_PATH/bin/qt-cmake -G "Ninja" \
    -S . \
    -B $BUILD_DIR \
    -DANDROID_SDK_ROOT="$ANDROID_SDK_ROOT" \
    -DANDROID_NDK_ROOT="$ANDROID_NDK_ROOT" \
    -DANDROID_ABI="$TARGET_ABI" \
    -DANDROID_PLATFORM="android-$ANDROID_API_LEVEL"

echo "=== [2/3] Компиляция C++ и QML ресурсов (Ninja) ==="
cmake --build $BUILD_DIR --target all

echo "=== [3/3] Упаковка в APK (androiddeployqt) ==="
# Команда 'apk' запускает сборку финального пакета через Gradle
cmake --build $BUILD_DIR --target apk

echo "=== Сборка завершена! Готовый APK ищите в недрах папки $BUILD_DIR ==="

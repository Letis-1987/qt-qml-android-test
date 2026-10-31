#!/bin/bash
# Останавливать выполнение скрипта при любой ошибке
set -e

echo "=== Запуск процесса сборки Qt Android проекта ==="

# Определение путей сборки
BUILD_DIR="build"
QT_CMAKE_TOOLCHAIN="${QT_ANDROID_DIR}/lib/cmake/Qt6/qt.toolchain.cmake"

# Удаление старой сборки, если она существует
if [ -d "$BUILD_DIR" ]; then
    echo "Очистка старой директории сборки..."
    rm -rf "$BUILD_DIR"
fi

mkdir "$BUILD_DIR"
cd "$BUILD_DIR"

echo "=== Шаг 1: Конфигурация проекта через CMake ==="
# Основные параметры:
# - CMAKE_TOOLCHAIN_FILE: Передает настройки Qt для кросс-компиляции под Android
# - ANDROID_ABI: Явно задаем архитектуру arm64-v8a
# - ANDROID_PLATFORM: Указываем API 35 (как установлено в SDK)
cmake .. -G Ninja \
    -DCMAKE_TOOLCHAIN_FILE="${QT_CMAKE_TOOLCHAIN}" \
    -DANDROID_ABI="arm64-v8a" \
    -DANDROID_PLATFORM="latest" \
    -DCMAKE_BUILD_TYPE="Release"

echo "=== Шаг 2: Компиляция и сборка APK ==="
# Цель 'apk' заставит CMake не просто скомпилировать бинарники, 
# но и вызвать androiddeployqt для упаковки в готовый .apk пакет
cmake --build . --target apk

echo "=== Сборка успешно завершена! ==="

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

# Задаем путь к хостовой (Linux x64) версии Qt для инструментов сборки
QT_HOST_DIR="${QT_PATH}/${QT_VERSION}/gcc_64"

cmake .. -G Ninja \
    -DCMAKE_TOOLCHAIN_FILE="${QT_CMAKE_TOOLCHAIN}" \
    -DANDROID_ABI="arm64-v8a" \
    -DANDROID_PLATFORM="android-34" \
    -DCMAKE_BUILD_TYPE="Release" \
    -DQT_HOST_PATH="${QT_HOST_DIR}"

echo "=== Шаг 2: Компиляция и сборка APK ==="
# Цель 'apk' заставит CMake не просто скомпилировать бинарники, 
# но и вызвать androiddeployqt для упаковки в готовый .apk пакет
cmake --build . --target apk

echo "=== Сборка успешно завершена! ==="

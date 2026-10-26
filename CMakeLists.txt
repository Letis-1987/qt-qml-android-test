cmake_minimum_required(VERSION 3.16)

project(AndroidApp VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Поиск модуля Qt Quick
find_package(Qt6 REQUIRED COMPONENTS Quick)

# Оптимальные настройки развертывания под Android от Qt
qt_standard_project_setup()

# Создаем исполняемый файл
qt_add_executable(appAndroidApp main.cpp)

# Регистрируем QML-модуль. Он САМ сгенерирует виртуальный .qrc в фоне
qt_add_qml_module(appAndroidApp
    URI AndroidApp
    VERSION 1.0
    QML_FILES Main.qml
)

# Линковка базовых библиотек
target_link_libraries(appAndroidApp PRIVATE Qt6::Quick)

# Указываем папку для Android-специфичных ресурсов (манифест, иконки), если она есть
if(ANDROID)
    set_target_properties(appAndroidApp PROPERTIES
        QT_ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android"
    )
endif()

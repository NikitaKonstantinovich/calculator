cmake_minimum_required(VERSION 3.21)
project(calculator LANGUAGES CXX)

find_package(Qt6 6.8 REQUIRED COMPONENTS Quick Qml)
qt_standard_project_setup(REQUIRES 6.8)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Исполняемое приложение
qt_add_executable(appcalculator
    main.cpp
)

set_source_files_properties(Theme.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)

# QML прямо в таргете приложения (импорт: import App 1.0)
qt_add_qml_module(appcalculator
    URI App
    VERSION 1.0
    RESOURCE_PREFIX /qt/qml
    QML_FILES
        Main.qml
        Theme.qml
        components/CalcButton.qml
        QML_FILES components/StatusBar.qml
        QML_FILES components/WifiIcon.qml
        QML_FILES components/BatteryIcon.qml
        QML_FILES components/CellularIcon.qml
)

# Линковка
target_link_libraries(appcalculator PRIVATE Qt6::Quick Qt6::Qml)


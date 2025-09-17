//main.cpp
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "src/CalculatorModel.h"

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    qmlRegisterType<CalculatorModel>("App", 1, 0, "CalculatorModel");

    QQmlApplicationEngine engine;
    engine.loadFromModule("App", "Main");
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}

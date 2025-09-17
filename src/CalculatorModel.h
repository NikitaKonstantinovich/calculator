#pragma once
#include <QObject>
#include <QString>
#include <QtQml/qqml.h>

class CalculatorModel : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString display READ display NOTIFY displayChanged)
    Q_PROPERTY(QString expression READ expression NOTIFY displayChanged)

public:
    explicit CalculatorModel(QObject* parent=nullptr);

    // ===== интерфейс =====
    Q_INVOKABLE void inputDigit(int d); // 0..9
    Q_INVOKABLE void inputDot();        // "."
    Q_INVOKABLE void toggleSign();      // ±
    Q_INVOKABLE void clearEntry();      // C
    Q_INVOKABLE void clearAll();      // long C (2s)
    Q_INVOKABLE void pressOp(const QString& op); // "+", "-", "×", "÷"
    Q_INVOKABLE void pressBrackets();  // "()"
    Q_INVOKABLE void equals();
    Q_INVOKABLE void percent();

    QString display() const { return m_display; }
    QString expression() const { return m_expr; }

signals:
    void displayChanged();

private:
    // состояние этой итерации (только ввод)
    QString m_cur;      // строка набора, например "-12.30"
    QString m_display;  // нормализованная версия
    QString m_expr;     // верхняя строка

    static constexpr int kMaxDigits = 25;

    bool m_parenOpen = false;
    bool m_lastWasEquals = false;

    // утилиты
    static int countDigits(const QString& s);
    static QString stripTrailingZeros(QString s);
    static QString normalize(QString s);
    static QChar canonicalOp(QChar c);   // нормализуем операторы: ×→*, ÷→/, −→-
    void updateDisplay();

    static bool isAddSub(QChar c);
    static bool isMulDiv(QChar c);
    static bool isOperator(QChar c);
    static QString normalizeNumber(QString s);
    static QString normalizeSigns(const QString& expr, const QString& op); // сворачивание ++,+-,-+,--
    void flushEntryToExpr();

    // вычисление
    QString evaluate(const QString& fullExpr); // токенизация + расчёт без вложенных скобок
    QString evalFlat(const QStringList& tokens); // приоритет × ÷, затем + -
};

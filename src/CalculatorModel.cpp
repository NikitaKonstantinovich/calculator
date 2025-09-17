#include "CalculatorModel.h"
#include <QStringList>
#include <limits>
#include <string>
#include <cstdlib>

CalculatorModel::CalculatorModel(QObject* parent) : QObject(parent) {
    m_cur = "0";
    m_expr.clear();
    updateDisplay();
}

int CalculatorModel::countDigits(const QString& s) {
    int count = 0;
    for (QChar ch: s) if (ch.isDigit()) ++count;
    return count;
}

QString CalculatorModel::stripTrailingZeros(QString s) {
    // int dot = s.indexOf('.');
    // if (dot < 0) return s;
    // while(s.endsWith('0')) s.chop(1);
    // if (s.endsWith('.')) s.chop(1);
    if (s.isEmpty() || s == "-") s = "0";
    return s;
}

QString CalculatorModel::normalize(QString s) {
    if (s.isEmpty()) return "0";

    bool neg = s.startsWith('-');
    if (neg) s.remove(0, 1);

    if (s.startsWith('.')) s.prepend("0");

    int dot = s.indexOf('.');
    if (dot >= 0) {
        QString intp = s.left(dot);
        QString frac = s.mid(dot + 1);

        int i = 0;
        while (i < intp.size() - 1 && intp[i] == '0') ++i;
        intp = intp.mid(i);

        s = intp + "." + frac;
        s = stripTrailingZeros(s);
    } else {
        int i = 0;
        while (i < s.size() - 1 && s[i] == '0') ++i;
        s = s.mid(i);
    }

    if (s == "0") neg = false;
    if (neg) s.prepend('-');
    return s.isEmpty() ? "0" : s;
}

void CalculatorModel::updateDisplay() {
    m_display = normalize(m_cur);
    emit displayChanged();
}

void CalculatorModel::inputDigit(int d) {
    if (d < 0 || d > 9) return;
    if (countDigits(m_cur) >= kMaxDigits) return;

    if (m_cur == "0") m_cur.clear();
    if (m_cur == "-0") m_cur = "-";

    m_cur += QString::number(d);
    updateDisplay();
}

void CalculatorModel::inputDot() {
    if (m_cur.isEmpty()) m_cur = "0";
    if (!m_cur.contains('.')) {
        m_cur += '.';
        updateDisplay();
    }
}

void CalculatorModel::toggleSign() {
    if (m_cur.startsWith('-')) m_cur.remove(0, 1);
    else if (m_cur != "0") m_cur.prepend('-');
    updateDisplay();
}

void CalculatorModel::clearEntry() {
    m_cur = "0";
    updateDisplay();
}

void CalculatorModel::clearAll() {
    m_cur = "0";
    m_display = "0";
    m_expr = "";
    emit displayChanged();
}

// === выражение/операции ===
static inline QChar asAsciiMinus(QChar c) {
    return (c == QChar(u'−')) ? QChar('-') : c;
}

bool CalculatorModel::isAddSub(QChar c) {
    c = canonicalOp(c);
    return c == '+' || c == '-';
}

bool CalculatorModel::isMulDiv(QChar c) {
    c = canonicalOp(c);
    return c == '*' || c == '/';
}

bool CalculatorModel::isOperator(QChar c) {
    return CalculatorModel::isAddSub(c) || CalculatorModel::isMulDiv(c);
}

QString CalculatorModel::normalizeNumber(QString s) {
    if (s.isEmpty()) return {};
    if (s.startsWith("."))
        s.prepend('0');
    if (s.startsWith("-."))
        s.insert(1, '0');
    return s;
}

QChar CalculatorModel::canonicalOp(QChar c) {
    if (c == QChar(u'×')) return QChar('*');
    if (c == QChar(u'÷')) return QChar('/');
    if (c == QChar(u'−')) return QChar('-');
    return c;
}

QString CalculatorModel::normalizeSigns(const QString& expr, const QString& incomingOp) {
    if (expr.isEmpty() || incomingOp.isEmpty()) return expr + incomingOp;

    QChar last = expr.back();
    QChar in   = incomingOp.front();
    last = asAsciiMinus(last);
    in   = asAsciiMinus(in);

    if ((last == '+' || last == '-') && (in == '+' || in == '-')) {
        // ++ -> +, +- -> -, -+ -> -, -- -> +
        QChar r = (last == in) ? QChar('+') : QChar('-');
        QString out = expr;
        out.chop(1);
        out.append(r);
        return out;
    }
    return expr + incomingOp;
}

void CalculatorModel::flushEntryToExpr() {
    QString num = normalizeNumber(m_cur);
    if (num.isEmpty()) num = "0";

    if (m_expr.isEmpty()) {
        m_expr = num;
    } else {
        QChar last = m_expr.back();
        if (last == '(' || isAddSub(last) || isMulDiv(last))
            m_expr += num;
        else
            m_expr += num;
    }
    m_cur.clear();
}

void CalculatorModel::pressOp(const QString& op) {
    if (!( !m_expr.isEmpty() && m_expr.back() == ')' )) {
        if (m_cur.isEmpty()) m_cur = "0";
        flushEntryToExpr();
    }

    // Нормализуем оператор и добавляем
    if (op == "×" || op == "*" || op == "÷" || op == "/") {
        const QString realOp = (op == "×" ? "×" : (op == "÷" ? "÷" : op));
        m_expr += realOp;
    } else {
        m_expr = normalizeSigns(m_expr, op); // ++,+-,-+,-- сворачиваем
    }

    m_lastWasEquals = false;
    updateDisplay();
}

void CalculatorModel::pressBrackets() {
    if (!m_parenOpen) {
        if (m_cur.isEmpty() || m_cur == "0") {
            if (!m_expr.isEmpty()) {
                QChar last = m_expr.back();
                // если перед "(" стоит число или ')', вставим '+' (линейная запись)
                if (last.isDigit() || last == ')') m_expr += '+';
            }
            m_expr += '(';
            m_parenOpen = true;
            m_cur.clear();
            m_lastWasEquals = false;
            updateDisplay();
        }
    } else {
        // скобка открыта — закрываем: сперва переносим текущее число
        flushEntryToExpr();
        m_expr += ')';
        m_parenOpen = false;
        m_lastWasEquals = false;
        updateDisplay();
    }
}

// ===== вычисление =====
static long double applyOp(long double a, long double b, QChar op){
    if (op == QChar(u'×')) op = '*';
    else if (op == QChar(u'÷')) op = '/';
    else if (op == QChar(u'−')) op = '-';

    switch (op.unicode()) {
    case '+': return a + b;
    case '-': return a - b;
    case '*': return a * b;
    case '/': return (b == 0.0L)
                   ? std::numeric_limits<long double>::quiet_NaN()
                   : a / b;
    default:  return b;
    }
}

QString CalculatorModel::evalFlat(const QStringList& tokens) {
    if (tokens.isEmpty()) return QStringLiteral("0");

    auto toLD = [](const QString& s)->long double {
        return std::strtold(s.toStdString().c_str(), nullptr);
    };

    // 1) сначала * и /
    QStringList t = tokens;
    for (int i = 1; i + 1 < t.size(); ) {
        if (t[i].size() == 1 && isMulDiv(t[i][0])) {
            // защита от краёв
            if (i - 1 < 0 || i + 1 >= t.size())
                return QStringLiteral("NaN");

            long double a = toLD(t[i - 1]);
            long double b = toLD(t[i + 1]);
            long double r = applyOp(a, b, t[i][0]);

            t[i - 1] = QString::number(r, 'g', 15);
            t.removeAt(i);   // op
            t.removeAt(i);   // b
            // остаёмся на позиции i (там мог оказаться ещё один * или /)
        } else {
            i += 2; // число, оп, число → прыгаем к следующей паре
        }
    }

    // 2) затем + и -
    if (t.isEmpty()) return QStringLiteral("0");
    long double acc = toLD(t[0]);
    for (int i = 1; i + 1 < t.size(); i += 2) {
        if (!(t[i].size() == 1 && isAddSub(t[i][0])))
            break; // неожиданное — прекращаем
        long double b = toLD(t[i + 1]);
        acc = applyOp(acc, b, t[i][0]);
    }

    return QString::number(acc, 'g', 15);
}


QString CalculatorModel::evaluate(const QString& fullExpr) {
    // --- 1) Токенизация: числа (с унарным '-'), операторы и скобки ---
    QStringList tok;
    QString cur;

    auto pushNum = [&](){
        if (!cur.isEmpty()) { tok << cur; cur.clear(); }
    };

    auto isUnaryMinusAt = [&](int i)->bool {
        if (i < 0 || i >= fullExpr.size()) return false;
        QChar ch = fullExpr[i];
        if (ch != '-' && ch != QChar(u'−')) return false;
        if (i == 0) return true;
        QChar prev = fullExpr[i-1];
        // унарный минус после '(' или после любого оператора
        return prev == '(' || isAddSub(prev) || isMulDiv(prev);
    };

    for (int i = 0; i < fullExpr.size(); ++i) {
        QChar ch = fullExpr[i];
        if (ch.isDigit() || ch == '.' || isUnaryMinusAt(i)) {
            // нормализуем минус к ASCII
            cur += (ch == QChar(u'−') ? QChar('-') : ch);
        } else {
            pushNum();
            if (ch == '(' || ch == ')' || isAddSub(ch) || isMulDiv(ch))
                tok << QString(canonicalOp(ch));
        }
    }
    pushNum();

    // --- 2) Защита: удаляем ведущие/хвостовые операторы в плоском списке ---
    // Ведущие операторы (например, ["+","12","×","5"] -> ["12","×","5"])
    while (!tok.isEmpty()) {
        if (tok.first().size() == 1) {
            QChar c = tok.first()[0];
            if (isAddSub(c) || isMulDiv(c)) { tok.removeFirst(); continue; }
        }
        break;
    }
    // Хвостовые операторы (например, ["12","+"] -> ["12"])
    while (!tok.isEmpty()) {
        if (tok.last().size() == 1) {
            QChar c = tok.last()[0];
            if (isAddSub(c) || isMulDiv(c)) { tok.removeLast(); continue; }
        }
        break;
    }
    if (tok.isEmpty()) return QStringLiteral("0");

    // --- 3) Скобки без вложений: считаем пары ( ... ) слева направо ---
    while (true) {
        int l = tok.lastIndexOf("(");
        if (l < 0) break;                 // скобок больше нет
        int r = tok.indexOf(")", l + 1);
        if (r < 0) return QStringLiteral("NaN"); // несбалансировано
        if (r <= l + 1) return QStringLiteral("NaN"); // пустые скобки "()"

        // вытащить содержимое и посчитать его плоско
        const QStringList inner = tok.mid(l + 1, r - l - 1);
        if (inner.isEmpty()) return QStringLiteral("NaN");
        const QString val = evalFlat(inner);

        // заменить диапазон [l..r] на единственный токен val
        tok.erase(tok.begin() + l, tok.begin() + r + 1);
        tok.insert(l, val);
        if (tok.isEmpty()) return QStringLiteral("NaN");
    }

    // финальная зачистка хвостовых операторов на всякий случай
    while (!tok.isEmpty()) {
        if (tok.last().size() == 1) {
            QChar c = tok.last()[0];
            if (isAddSub(c) || isMulDiv(c)) { tok.removeLast(); continue; }
        }
        break;
    }
    if (tok.isEmpty()) return QStringLiteral("0");

    // --- 4) Плоский расчёт (× ÷ → + -) ---
    return evalFlat(tok);
}

// ===== действия =====
void CalculatorModel::equals() {
    // закрыть скобку, если была открыта
    if (m_parenOpen) {
        if (!m_cur.isEmpty())
            flushEntryToExpr();
        m_expr += ')';
        m_parenOpen = false;
    } else {
        if (!m_cur.isEmpty())
            flushEntryToExpr();
    }

    // убрать висящие операторы в конце (... + / × −)
    while (!m_expr.isEmpty() && isOperator(m_expr.back())) {
        m_expr.chop(1);
    }
    if (m_expr.isEmpty()) { updateDisplay(); return; }

    const QString full = m_expr;
    const QString res  = evaluate(full);

    m_expr = full + QStringLiteral(" =");
    m_cur  = res;
    m_lastWasEquals = true;
    updateDisplay();
}

void CalculatorModel::percent() {
    if (!m_lastWasEquals) return;
    if (m_cur.isEmpty()) m_cur = "0";
    long double v = std::strtold(m_cur.toStdString().c_str(), nullptr);
    v /= 100.0L;
    m_cur = QString::fromStdString(std::to_string(v));
    updateDisplay();
}

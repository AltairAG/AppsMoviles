import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorProvider extends ChangeNotifier {
  String _display = '';

  String get display => _display;

  void append(String value) {
    if (value == '=') {
      calculate();
    } else if (value == 'C') {
      clear();
    } else {
      _display += value;
      notifyListeners();
    }
  }

  void clear() {
    _display = '';
    notifyListeners();
  }

  void calculate() {
    try {
      String expression = _display
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('−', '-');

      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      _display = eval.toString();
    } catch (e) {
      _display = 'Error';
    }
    notifyListeners();
  }

  double _evaluateExpression(String expr) {
    final tokens = RegExp(r'(\d+\.?\d*|\+|\-|\*|/)+').allMatches(expr);
    final List<String> parts = tokens.map((e) => e.group(0)!).toList();

    double result = double.parse(parts[0]);
    for (int i = 1; i < parts.length; i += 2) {
      String op = parts[i];
      double next = double.parse(parts[i + 1]);
      switch (op) {
        case '+':
          result += next;
          break;
        case '-':
          result -= next;
          break;
        case '*':
          result *= next;
          break;
        case '/':
          result /= next;
          break;
      }
    }
    return result;
  }
}

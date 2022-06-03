import 'package:flutter_calculator/view_model/number_formatter.dart';

class Calculations {
  static const period = '.';
  static const multiple = '*';
  static const subtract = '-';
  static const add = '+';
  static const divide = '/';
  static const clear = 'clear';
  static const equal = '=';
  static const operations = [
    Calculations.add,
    Calculations.divide,
    Calculations.subtract,
    Calculations.divide,
  ];

  static double plus(double a, double b) => a + b;
  static double minus(double a, double b) => a - b;
  static double divideAtoB(double a, double b) => a / b;
  static double multiply(double a, double b) => a * b;
}

class Calculator {
  static String parseString(String text) {
    List<String> numbersToAdd;
    double a, b, res;

    if (text.contains(Calculations.add)) {
      numbersToAdd = text.split(Calculations.add);
      a = double.parse(numbersToAdd[0]);
      b = double.parse(numbersToAdd[1]);
      res = Calculations.plus(a, b);
    } else if (text.contains(Calculations.multiple)) {
      numbersToAdd = text.split(Calculations.multiple);
      a = double.parse(numbersToAdd[0]);
      b = double.parse(numbersToAdd[1]);
      res = Calculations.multiply(a, b);
    } else if (text.contains(Calculations.divide)) {
      numbersToAdd = text.split(Calculations.divide);
      a = double.parse(numbersToAdd[0]);
      b = double.parse(numbersToAdd[1]);
      res = Calculations.divideAtoB(a, b);
    } else if (text.contains(Calculations.subtract)) {
      numbersToAdd = text.split(Calculations.subtract);
      a = double.parse(numbersToAdd[0]);
      b = double.parse(numbersToAdd[1]);
      res = Calculations.minus(a, b);
    } else {
      return text;
    }

    return NumberFormatter.format(res.toString());
  }

  static String addPeriod(String calculator) {
    if (calculator.isEmpty) {
      return calculator = '0${Calculations.period}';
    }

    RegExp exp = RegExp(r"\d\.");
    Iterable<Match> matches = exp.allMatches(calculator);
    int maxMatches = Calculator.includesOperation(calculator) ? 2 : 1;

    return matches.length == maxMatches
        ? calculator
        : calculator += Calculations.period;
  }

  static bool includesOperation(String calculator) {
    // TODO Refactoring
    for (var operation in Calculations.operations) {
      if (calculator.contains(operation)) {
        return true;
      }
    }

    return false;
  }
}

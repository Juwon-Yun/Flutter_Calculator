import 'package:flutter/material.dart';

class CalculatorProvider extends ChangeNotifier {
  bool _isEquation = true;
  String _calContent = '';
  String _answer = '';
  List<String> _operations = [];
  List<String> _calculations = [];

  bool get isEquation => _isEquation;
  String get calContent => _calContent;
  String get answer => _answer;
  List<String> get operations => _operations;
  List<String> get calculations => _calculations;

  void setIsEquation() {
    _isEquation = true;
  }

  void setIsNotEquation() {
    _isEquation = false;
  }

  void addOperations(String text) {
    _operations.add(text);
  }

  void addCalculations(String text) {
    _calculations.add(text);
  }

  void attachCalContent(String text) {
    _calContent += text;
  }

  void initCalContent() {
    _calContent = '';
  }

  void substituteAnswer(String text) {
    _answer = text;
  }

  void initAnswer() {
    _answer = '';
  }

  bool isEmpty(String text) {
    if (text == "") {
      return true;
    }
    return false;
  }
}

import 'package:flutter/material.dart';

class CalculatorProvider extends ChangeNotifier{
  bool isEquation = true;
  String calContent = '';
  String answer = '';
  List<String> operations = [];
  List<String> calculations = [];


}
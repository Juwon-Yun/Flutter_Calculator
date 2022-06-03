import 'package:flutter/material.dart';

typedef CalculatorButtonTapCallback = void Function({String buttonText});

class CalculatorButton extends StatelessWidget {
  const CalculatorButton({Key? key, required this.text, required this.onTap})
      : super(key: key);
  final String text;
  final CalculatorButtonTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.white10,
        width: 0.5,
      )),
      child: ElevatedButton(
        onPressed: () => onTap(buttonText: text),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        // style: ElevatedButtonTheme.of(context).style.backgroundColor(Colors.white10),
      ),
    );
  }
}

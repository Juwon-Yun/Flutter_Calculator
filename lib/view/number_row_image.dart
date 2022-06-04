import 'package:flutter/material.dart';
import 'package:flutter_calculator/view_model/calculator.dart';

class NumberRowImage extends StatelessWidget {
  final String text;
  const NumberRowImage({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: text
            .split("")
            .map((e) => Image.asset(
                  'asset/img/$e.png',
                  width: 50,
                  height: 70,
                  fit: BoxFit.contain,
                ))
            .toList(),
      ),
    );
  }
}

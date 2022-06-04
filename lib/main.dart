import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_calculator/view/number_row_image.dart';
import 'package:flutter_calculator/view_model/calculator.dart';

void main() {
  runApp(CalculatorWidget());
}

class CalculatorWidget extends StatefulWidget {
  const CalculatorWidget({Key? key}) : super(key: key);

  @override
  State<CalculatorWidget> createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  bool isEquation = true;
  String calContent = '';
  String answer = '';
  List<String> operations = [];
  List<String> calculations = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF2D2D33),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const _Header(),
                _Body(calContent: calContent, answer: answer),
                Expanded(
                  child: GridView.builder(
                      itemCount: Calculations.calculatorButtonRows.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 6),
                      itemBuilder: (BuildContext context, index) {
                        String buttonText =
                            Calculations.calculatorButtonRows[index];

                        return ElevatedButton(
                          onPressed: () {
                            if (buttonText == Calculations.clear) {
                              setState(() {
                                operations.add(Calculations.clear);
                                calContent = "";
                                answer = "";
                              });
                              return;
                            }

                            if (buttonText == Calculations.equal) {
                              String newCalContent =
                                  Calculator.parseString(calContent);

                              setState(() {
                                if (newCalContent != calContent) {
                                  calculations.add(calContent);
                                }
                                operations.add(Calculations.equal);
                                answer = newCalContent;
                                isEquation = false;
                              });
                              return;
                            }

                            if (Calculations.operations.contains(buttonText)) {
                              if (calContent == "") return;
                              // if(buttonText == "=") return;
                              setState(() {
                                calContent += buttonText;
                                operations.add(buttonText);
                                // calContent += " $buttonText ";
                              });
                              return;
                            }

                            if (buttonText == Calculations.period) {
                              return setState(() {
                                calContent = Calculator.addPeriod(calContent);
                              });
                            }

                            setState(() {
                              if (!isEquation &&
                                  operations.isNotEmpty &&
                                  operations.last == Calculations.equal) {
                                answer = buttonText;
                                isEquation = true;
                              } else {
                                calContent += buttonText;
                                answer = "";
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red[400],
                            maximumSize: const Size(80, 80),
                          ),
                          child: Text(
                            Calculations.calculatorButtonRows[index] == "d"
                                ? "/"
                                : Calculations.calculatorButtonRows[index],
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
    required this.calContent,
    required this.answer,
  }) : super(key: key);

  final String calContent;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Text(
                //   calContent,
                //   style: const TextStyle(
                //       color: Colors.white,
                //       fontWeight: FontWeight.w400,
                //       fontSize: 20),
                // ),
                NumberRowImage(text: calContent),
                NumberRowImage(text: answer)
                // Text(
                //   answer,
                //   style: const TextStyle(
                //       color: Colors.white,
                //       fontWeight: FontWeight.w700,
                //       fontSize: 60),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '계산기',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 30.0),
        ),
        // IconButton(
        //     onPressed: () {},
        //     icon: const Icon(
        //       Icons.history,
        //       color: Colors.white,
        //       size: 35,
        //     ))
      ],
    );
  }
}

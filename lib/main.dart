import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  String calContent = '123';

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
                _Header(),
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          calContent,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
                // Row(
                //   children: Calculations.calculatorButtonRows
                //       .map(
                //           (str) => ElevatedButton(
                //             onPressed: () {},
                //             child: Text(str),
                //             style: ElevatedButton.styleFrom(
                //                 primary: Colors.red[200],
                //                 maximumSize: Size(80, 40),
                //             ),
                //           ))
                //       .toList(),
                // ),
                Expanded(
                  child: GridView.builder(
                      itemCount: Calculations.calculatorButtonRows.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 6),
                      itemBuilder: (BuildContext context, index) {
                        return ElevatedButton(
                          onPressed: () {
                            if(Calculations.calculatorButtonRows[index] == '1'){
                              setState((){
                                calContent += '1';
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red[400],
                            maximumSize: const Size(80, 80),
                          ),
                          child: Text(
                            Calculations.calculatorButtonRows[index],
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
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 30.0),
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.history,
              color: Colors.white,
              size: 35,
            ))
      ],
    );
  }
}

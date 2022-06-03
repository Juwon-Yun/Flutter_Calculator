import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_calculator/view_model/calculator.dart';
import 'package:flutter_calculator/view_model/calculator_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (_) => CalculatorProvider(),
        child: CalculatorWidget(),
      ),
    );
  }
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

  late CalculatorProvider _calculatorProvider;

  @override
  Widget build(BuildContext context) {
    _calculatorProvider =
        Provider.of<CalculatorProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _Header(),
              _Body(),
              Expanded(
                child: Consumer<CalculatorProvider>(
                  builder: (context, calculatorProvider, child) =>
                      GridView.builder(
                          itemCount: Calculations.calculatorButtonRows.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 6),
                          itemBuilder: (BuildContext context, index) {
                            String buttonText =
                                Calculations.calculatorButtonRows[index];
                            return ElevatedButton(
                              onPressed: () {
                                if (Calculations.operations
                                    .contains(buttonText)) {
                                  // if (calContent == "") return;
                                  if (Provider.of<CalculatorProvider>(context)
                                          .calContent ==
                                      "") return;
                                  // setState(() {
                                  //   operations.add(buttonText);
                                  //   calContent += " $buttonText ";
                                  // });
                                  Provider.of<CalculatorProvider>(context)
                                      .addOperations(buttonText);
                                  Provider.of<CalculatorProvider>(context)
                                      .attachCalContent(' $buttonText ');
                                  return;
                                }

                                if (buttonText == Calculations.clear) {
                                  // setState(() {
                                  //   operations.add(Calculations.clear);
                                  //   calContent = "";
                                  //   answer = "";
                                  // });
                                  Provider.of<CalculatorProvider>(context)
                                      .addOperations(Calculations.clear);
                                  Provider.of<CalculatorProvider>(context)
                                      .initCalContent();
                                  Provider.of<CalculatorProvider>(context)
                                      .initAnswer();
                                  return;
                                }

                                if (buttonText == Calculations.equal) {
                                  // String newCalContent =
                                  //     Calculator.parseString(calContent);
                                  String newCalContent = Calculator.parseString(
                                      Provider.of<CalculatorProvider>(context)
                                          .calContent);

                                  // setState(() {
                                  //   if (newCalContent != calContent) {
                                  //   calculations.add(calContent);
                                  // calculations.add(calContent);
                                  // operations.add(Calculations.equal);
                                  // answer = newCalContent;
                                  // isEquation = false;
                                  // });

                                  if (newCalContent !=
                                      Provider.of<CalculatorProvider>(context)
                                          .calContent) {
                                    Provider.of<CalculatorProvider>(context)
                                        .addCalculations(
                                            Provider.of<CalculatorProvider>(
                                                    context)
                                                .calContent);
                                  }
                                  Provider.of<CalculatorProvider>(context)
                                      .addOperations(Calculations.equal);
                                  Provider.of<CalculatorProvider>(context)
                                      .substituteAnswer(newCalContent);
                                  Provider.of<CalculatorProvider>(context)
                                      .setIsNotEquation();
                                  return;
                                }

                                if (buttonText == Calculations.period) {
                                  // return setState(() {
                                  //   calContent =
                                  //       Calculator.addPeriod(calContent);
                                  // });
                                  Provider.of<CalculatorProvider>(context)
                                      .attachCalContent(Calculator.addPeriod(
                                          Provider.of<CalculatorProvider>(
                                                  context)
                                              .calContent));
                                  return;
                                }

                                // setState(() {
                                //   if (!isEquation &&
                                //       operations.isNotEmpty &&
                                //       operations.last == Calculations.equal) {
                                //     answer = buttonText;
                                //     isEquation = true;
                                //   } else {
                                //     calContent += buttonText;
                                //   }
                                // });
                                if (!Provider.of<CalculatorProvider>(context)
                                        .isEquation &&
                                    Provider.of<CalculatorProvider>(context)
                                        .operations
                                        .isNotEmpty &&
                                    Provider.of<CalculatorProvider>(context)
                                            .operations
                                            .last ==
                                        Calculations.equal) {
                                  Provider.of<CalculatorProvider>(context)
                                      .substituteAnswer(buttonText);
                                  Provider.of<CalculatorProvider>(context)
                                      .setIsEquation();
                                } else {
                                  Provider.of<CalculatorProvider>(context)
                                      .attachCalContent(buttonText);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey[400],
                                maximumSize: const Size(80, 80),
                              ),
                              child: Text(
                                Calculations.calculatorButtonRows[index],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 20),
                              ),
                            );
                          }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Consumer<CalculatorProvider>(
        builder: (context, calculatorProvider, child) => Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    Provider.of<CalculatorProvider>(context).calContent,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 20),
                  ),
                  Text(
                    Provider.of<CalculatorProvider>(context).answer,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 60),
                  ),
                ],
              ),
            )
          ],
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
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 30.0),
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

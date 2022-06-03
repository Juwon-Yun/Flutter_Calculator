import 'package:flutter/material.dart';
import 'package:flutter_calculator/view_model/calculator.dart';
import 'package:flutter_calculator/view/number_display.dart';

void main() => runApp(const CalC());

class CalC extends StatelessWidget {
  const CalC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      debugShowCheckedModeBanner: false,
      home: MainPage(title: 'Calculator'),
    );
  }
}

class MainPage extends StatefulWidget {
  final String title;
  const MainPage({Key? key, required this.title}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isNewEquation = true;
  List<double> values = [];
  List<String> operations = [];
  List<String> calculations = [];
  String calculationContent = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.history)),
        ],
      ),
      body: Column(
        children: [
          NumberDisplay(value: calculationContent),
        ],
      ),
    );
  }

  // _navigateToHistory(BuildContext context) async {
  //   final res = await Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => History(operations: calculations)));
  //
  //   if (res != null) {
  //     setState(() {
  //       isNewEquation = false;
  //       calculationContent = Calculator.parseString(res);
  //     });
  //   }
  // }

  void _onPressed({required String buttonText}) {
    if (Calculations.operations.contains(buttonText)) {
      return setState(() {
        operations.add(buttonText);
        calculationContent = " $buttonText ";
      });
    }

    if (buttonText == Calculations.clear) {
      return setState(() {
        operations.add(Calculations.clear);
        calculationContent = "";
      });
    }

    if (buttonText == Calculations.equal) {
      String newContent = Calculator.parseString(calculationContent);

      return setState(() {
        if (newContent != calculationContent) {
          calculations.add(calculationContent);
        }
        operations.add(Calculations.equal);
        calculationContent = newContent;
        isNewEquation = false;
      });
    }

    if(buttonText == Calculations.period){
      return setState((){
        calculationContent = Calculator.addPeriod(calculationContent);
      });
    }

    setState((){
      // TODO Refactoring
      if(!isNewEquation && operations.length > 0 && operations.last == Calculations.equal){
        calculationContent = buttonText;
        isNewEquation = true;
      } else {
        calculationContent += buttonText;
      }
    });

  }
}

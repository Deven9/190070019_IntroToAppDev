import 'dart:math';

import 'package:flutter/material.dart';
import './widgets/SymbolButton.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> portraitSymbols = [
    'AC',
    '⌫',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '.',
    '0',
    '+/-',
    '=',
  ];
  final List<String> landscapeSymbols = [
    '0',
    '1',
    '2',
    '3',
    '4',
    'x',
    '/',
    'AC',
    '⌫',
    '5',
    '6',
    '7',
    '8',
    '9',
    '-',
    '+',
    '.',
    '0',
    '+/-',
    '=',
  ];
  var expression = '';
  var result = '';

  void findResult() {
    String finaluserinput = expression;
    finaluserinput = expression.replaceAll('x', '*');
    Expression exp = Parser().parse(expression);

    result = exp.evaluate(EvaluationType.REAL, ContextModel()).toString();
    expression = result;
  }

  Padding portraitColumn(var symbols) {
    return Padding(
      padding: MediaQuery.of(context).orientation == Orientation.portrait
          ? EdgeInsets.all(0)
          : MediaQuery.of(context).padding,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            alignment: Alignment.centerRight,
            child: Text(
              expression.isEmpty ? "Input" : expression,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 26,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            alignment: Alignment.centerRight,
            child: Text(
              result.isEmpty ? "0" : result,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 38,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(5),
              child: GridView.builder(
                itemCount: symbols.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 4
                        : 10),
                itemBuilder: (ctx, index) {
                  if (symbols[index] == 'AC') {
                    return SymbolButton(
                      click: () {
                        setState(() {
                          expression = '';
                          result = '';
                        });
                      },
                      bgcolor: Colors.orange,
                      text: symbols[index],
                      textcolor: Colors.white,
                    );
                  }
                  if (symbols[index] == '⌫') {
                    return SymbolButton(
                      click: () {
                        setState(() {
                          expression =
                              expression.substring(0, expression.length - 1);
                        });
                      },
                      bgcolor: Colors.red,
                      text: symbols[index],
                      textcolor: Colors.white,
                    );
                  }
                  if (symbols[index] == '=') {
                    return SymbolButton(
                      click: () {
                        setState(() {
                          findResult();
                        });
                      },
                      bgcolor: Colors.green,
                      text: symbols[index],
                      textcolor: Colors.white,
                    );
                  }
                  if (symbols[index] == '/' ||
                      symbols[index] == '+' ||
                      symbols[index] == '-' ||
                      symbols[index] == 'x' ||
                      symbols[index] == '%' ||
                      symbols[index] == '.' ||
                      symbols[index] == '+/-') {
                    return SymbolButton(
                      click: () {
                        setState(() {
                          expression += symbols[index];
                        });
                      },
                      bgcolor: Colors.white60,
                      text: symbols[index],
                      textcolor: Colors.black,
                    );
                  }
                  return SymbolButton(
                    click: () {
                      setState(() {
                        expression += symbols[index];
                      });
                    },
                    bgcolor: Colors.black45,
                    text: symbols[index],
                    textcolor: Colors.white,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Calculator"),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.white24,
      body: MediaQuery.of(context).orientation == Orientation.portrait
          ? portraitColumn(portraitSymbols)
          : portraitColumn(landscapeSymbols),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  const CalculadoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.dark(),
      ),
      home: const CalculadoraHomePage()
    );
  }
}

class CalculadoraHomePage extends StatefulWidget {
  const CalculadoraHomePage({super.key});

  @override
  _CalculadoraHomePageState createState() => _CalculadoraHomePageState();
}

class _CalculadoraHomePageState extends State<CalculadoraHomePage> {
  String output = "0";
  String _output = "0";
  double? num1;
  double? num2;
  String operand = "";

  void buttonPressed(String buttonText) {
    setState(() {
      if(buttonText == "CC") {
        _clearALL();
      }else if(buttonText == "+" || 
        buttonText == "-" || 
        buttonText == "/" || 
        buttonText == "x" ){
        if(_output.isNotEmpty) {
          num1 = double.tryParse(_output);
          operand = buttonText;
          _output = "0";
        }
      } else if (buttonText == ".") {
        if(!_output.contains(".")) {
          _output += buttonText;
        }
      } else if(buttonText == "=") {
        if (num1 != null && _output.isNotEmpty){
          num2 = double.tryParse(_output);
          _calculateResult();
        }
      } else {
        if(_output == "0"){
          _output = buttonText;
        } else {
          _output += buttonText;
        }
      }
    output = _output;
    });
  }

  void _clearALL() {
    _output = "0";
    num1 = null;
    num2 = null;
    operand = "";
    output = "0";
  }

  void _calculateResult() {
    if (num2 == null) return; {
      switch (operand) {
        case "+":
          _output = (num1! + num2!).toString();
          break;
        case "-":
          _output = (num1! - num2!).toString();
          break;
        case "x":
          _output = (num1! * num2!).toString();
          break;
        case "/":
          if (num2 == 0) {
            _output = "Error";
          } else {
            _output = (num1! / num2!).toString();
          }
          break;
      }
      num1 = null;
      num2 = null;
      operand = "";
    }
  }

  Widget botones(String buttonText,{
    Color backgroundColor = Colors.white,
    Color textColor = Colors.white,
    Color bordercolor = Colors.black,
    double borderWidth = 2.0,
    }) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0)
          ),
          side: BorderSide(color: bordercolor, width: borderWidth),
          padding: const EdgeInsets.all(35),
        ),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: textColor
          ),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 12.0
            ),
            child: Text(
              output,
              style: const TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          const Expanded(
            child: Divider(),
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  botones("7",backgroundColor: Colors.grey.shade500),
                  botones("8",backgroundColor: Colors.grey.shade500),
                  botones("9",backgroundColor: Colors.grey.shade500),
                  botones("/", backgroundColor: Colors.amber)
                ]
              ),
              Row(
                children: <Widget>[
                  botones("4",backgroundColor: Colors.grey.shade500), 
                  botones("5",backgroundColor: Colors.grey.shade500), 
                  botones("6",backgroundColor: Colors.grey.shade500), 
                  botones("x", backgroundColor: Colors.amber)
                ]
              ),
              Row(children: <Widget>[
                botones("1",backgroundColor: Colors.grey.shade500), 
                botones("2",backgroundColor: Colors.grey.shade500), 
                botones("3",backgroundColor: Colors.grey.shade500), 
                botones("-", backgroundColor: Colors.amber)
                ]
              ),
              Row(children: <Widget>[
                botones("." ,backgroundColor: Colors.grey.shade500), 
                botones("0" ,backgroundColor: Colors.grey.shade500),
                botones("00",backgroundColor: Colors.grey.shade500),
                botones("+", backgroundColor: Colors.amber),
                ]
              ),
              Row(
                children: <Widget>[
                  botones("CC", backgroundColor: Colors.amber),
                  botones("=", backgroundColor: Colors.amber)
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}




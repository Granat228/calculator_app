import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  // Переменные для хранения состояния
  String _output = "0"; // Текущий вывод
  String _expression = ""; // Выражение (история)
  double _num1 = 0.0;
  double _num2 = 0.0;
  String _operand = ""; // Оператор: +, -, *, /

  // Функция, которая реагирует на нажатие кнопок
  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        // Очистка всего
        _output = "0";
        _expression = "";
        _num1 = 0.0;
        _num2 = 0.0;
        _operand = "";
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/") {
        // Сохраняем первое число и оператор
        _num1 = double.parse(_output);
        _operand = buttonText;
        _expression = _output + buttonText;
        _output = "0"; // Сбрасываем вывод для ввода второго числа
      } else if (buttonText == "=") {
        // Выполняем вычисление
        _num2 = double.parse(_output);
        _expression += _output;
        switch (_operand) {
          case "+":
            _output = (_num1 + _num2).toString();
            break;
          case "-":
            _output = (_num1 - _num2).toString();
            break;
          case "*":
            _output = (_num1 * _num2).toString();
            break;
          case "/":
            _output = (_num2 != 0) ? (_num1 / _num2).toString() : "Error";
            break;
        }
        _expression = "";
        _operand = "";
        _num1 = 0.0;
        _num2 = 0.0;
      } else {
        // Если нажата цифра или точка
        if (_output == "0") {
          _output = buttonText;
        } else {
          _output += buttonText;
        }
      }
    });
  }

  // Создаем кнопку-виджет
  Widget _buildButton(String buttonText, {Color color = Colors.white, Color textColor = Colors.black}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: textColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
          onPressed: () => _buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Калькулятор")),
      body: Container(
        child: Column(
          children: <Widget>[
            // Область вывода (дисплей)
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _expression,
                    style: TextStyle(fontSize: 18.0, color: Colors.grey),
                  ),
                  Text(
                    _output,
                    style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(child: Divider()),
            // Раскладка кнопок
            Column(
              children: [
                Row(children: [_buildButton("7"), _buildButton("8"), _buildButton("9"), _buildButton("/", color: Colors.orange)]),
                Row(children: [_buildButton("4"), _buildButton("5"), _buildButton("6"), _buildButton("*", color: Colors.orange)]),
                Row(children: [_buildButton("1"), _buildButton("2"), _buildButton("3"), _buildButton("-", color: Colors.orange)]),
                Row(children: [_buildButton("."), _buildButton("0"), _buildButton("00"), _buildButton("+", color: Colors.orange)]),
                Row(children: [_buildButton("C", color: Colors.red, textColor: Colors.white), _buildButton("=", color: Colors.green, textColor: Colors.white)]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
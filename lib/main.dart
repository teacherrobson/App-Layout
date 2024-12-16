import 'package:flutter/material.dart';

void main() {
  runApp(const MinhaClasse());
}

class MinhaClasse extends StatelessWidget {
  const MinhaClasse({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(253, 95, 228, 228),
        ),
        useMaterial3: true,
      ),
      home: const Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String _display = '0';
  String _operand = '';
  double? _firstValue;

  void _onNumberPressed(String number) {
    setState(() {
      if (_display == '0') {
        _display = number;
      } else {
        _display += number;
      }
    });
  }

  void _onOperandPressed(String operand) {
    setState(() {
      _firstValue = double.tryParse(_display);
      _display = '0';
      _operand = operand;
    });
  }

  void _onEqualPressed() {
    setState(() {
      if (_firstValue != null && _operand.isNotEmpty) {
        double? secondValue = double.tryParse(_display);
        if (secondValue != null) {
          switch (_operand) {
            case '+':
              _display = (_firstValue! + secondValue).toString();
              break;
            case '-':
              _display = (_firstValue! - secondValue).toString();
              break;
            case '*':
              _display = (_firstValue! * secondValue).toString();
              break;
            case '/':
              _display = secondValue != 0
                  ? (_firstValue! / secondValue).toString()
                  : 'Erro';
              break;
          }
        }
        _firstValue = null;
        _operand = '';
      }
    });
  }

  void _onClearPressed() {
    setState(() {
      _display = '0';
      _firstValue = null;
      _operand = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Calculadora do Robson'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(20.0),
              child: Text(
                _display,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton('7'),
                  _buildButton('8'),
                  _buildButton('9'),
                  _buildButton('/'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton('4'),
                  _buildButton('5'),
                  _buildButton('6'),
                  _buildButton('*'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton('1'),
                  _buildButton('2'),
                  _buildButton('3'),
                  _buildButton('-'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton('C'),
                  _buildButton('0'),
                  _buildButton('='),
                  _buildButton('+'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String label) {
    return ElevatedButton(
      onPressed: () {
        if (label == 'C') {
          _onClearPressed();
        } else if (label == '=') {
          _onEqualPressed();
        } else if ('+-*/'.contains(label)) {
          _onOperandPressed(label);
        } else {
          _onNumberPressed(label);
        }
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(20.0),
        textStyle: const TextStyle(fontSize: 12),
      ),
      child: Text(label),
    );
  }
}

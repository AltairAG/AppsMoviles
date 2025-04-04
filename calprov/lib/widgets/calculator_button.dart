import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/calculator_provider.dart';

class CalculatorButton extends StatelessWidget {
  final String text;

  const CalculatorButton(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CalculatorProvider>(context, listen: false);
    final bool isOperator = ['÷', '×', '−', '+', '='].contains(text);
    final bool isClear = text == 'C';

    return GestureDetector(
      onTap: () => provider.append(text),
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color:
              isOperator
                  ? Colors.orange
                  : isClear
                  ? Colors.red
                  : Colors.grey[800],
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

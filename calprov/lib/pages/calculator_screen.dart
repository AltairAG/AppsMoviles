import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/calculator_provider.dart';
import '../widgets/calculator_button.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CalculatorProvider>(context);
    final List<List<String>> layout = [
      ["7", "8", "9", "÷"],
      ["4", "5", "6", "×"],
      ["1", "2", "3", "−"],
      ["C", "0", "=", "+"],
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Display
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              color: Colors.grey[900],
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20),
              child: Text(
                provider.display,
                style: const TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Botones
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children:
                    layout.map((fila) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:
                              fila
                                  .map((text) => CalculatorButton(text))
                                  .toList(),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

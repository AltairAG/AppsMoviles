import 'package:flutter/material.dart';

class Optocal extends StatefulWidget {
  const Optocal({super.key});

  @override
  OptocalState createState() => OptocalState();
}

class OptocalState extends State<Optocal> {
  String selectedFrom = 'Snellen';
  String selectedTo = 'Snellen';

  final TextEditingController inputController = TextEditingController();
  String result = '';

  // Función de conversión
  String convertValue(String from, String to, String input) {
    try {
      double value;

      // Convertir el valor de entrada a un valor numérico base común: Decimal
      switch (from) {
        case 'Snellen':
          List<String> parts = input.split('/');
          if (parts.length != 2) return 'Formato Snellen inválido';
          double num = double.parse(parts[0]);
          double denom = double.parse(parts[1]);
          value = num / denom;
          break;
        case 'Metros':
          double metros = double.parse(input);
          value = 6 / metros;
          break;
        case 'Decimal':
          value = double.parse(input);
          break;
        case 'Mar':
          value = 1 / double.parse(input);
          break;
        default:
          return 'Conversión no soportada';
      }

      // Convertir de Decimal al formato destino
      switch (to) {
        case 'Snellen':
          double snellenDenom = 20 / value;
          return '20/${snellenDenom.toStringAsFixed(1)}';
        case 'Metros':
          double metros = 6 / (20 / value);
          return '${metros.toStringAsFixed(2)} m';
        case 'Decimal':
          return value.toStringAsFixed(2);
        case 'Mar':
          double mar = 1 / value;
          return mar.toStringAsFixed(2);
        default:
          return 'Conversión no soportada';
      }
    } catch (e) {
      return 'Error: Entrada inválida';
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> availableOptions = ['Snellen', 'Metros', 'Decimal', 'MAR'];
    availableOptions.remove(selectedFrom);

    return Scaffold(
      appBar: AppBar(
        title: Text('Conversiones'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: inputController,
                decoration: InputDecoration(
                  labelText: 'Ingrese valor',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(15),
                ),
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),

            Text('Convertir de:', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            SegmentedButton<String>(
              segments: [
                ButtonSegment(
                  value: 'Snellen',
                  label: Text(
                    'Snellen',
                    style: TextStyle(fontSize: 12),
                    overflow:
                        TextOverflow
                            .ellipsis, // Asegura que el texto largo no se desborde
                  ),
                ),
                ButtonSegment(
                  value: 'Metros',
                  label: Text(
                    'Metros',
                    style: TextStyle(fontSize: 12),
                    overflow:
                        TextOverflow
                            .ellipsis, // Asegura que el texto largo no se desborde
                  ),
                ),
                ButtonSegment(
                  value: 'Decimal',
                  label: Text(
                    'Decimal',
                    style: TextStyle(fontSize: 12),
                    overflow:
                        TextOverflow
                            .ellipsis, // Asegura que el texto largo no se desborde
                  ),
                ),
                ButtonSegment(
                  value: 'MAR',
                  label: Text(
                    'MAR',
                    style: TextStyle(fontSize: 12),
                    overflow:
                        TextOverflow
                            .ellipsis, // Asegura que el texto largo no se desborde
                  ),
                ),
              ],
              selected: {selectedFrom},
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  selectedFrom = newSelection.first;
                  selectedTo = availableOptions.first;
                });
              },
            ),
            SizedBox(height: 20),

            Text('Convertir a:', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            SegmentedButton<String>(
              segments:
                  availableOptions
                      .map(
                        (option) => ButtonSegment(
                          value: option,
                          label: Text(
                            option,
                            style: TextStyle(fontSize: 12),
                            overflow:
                                TextOverflow
                                    .ellipsis, // Asegura que el texto largo no se desborde
                          ),
                        ),
                      )
                      .toList(),
              selected: {selectedTo},
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  selectedTo = newSelection.first;
                });
              },
            ),
            SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: () {
                setState(() {
                  result = convertValue(
                    selectedFrom,
                    selectedTo,
                    inputController.text.trim(),
                  );
                });
              },
              child: Text(
                'Convertir',
                style: TextStyle(
                  fontSize: 18,
                  color: const Color.fromARGB(255, 46, 6, 6),
                ),
              ),
            ),
            SizedBox(height: 20),

            Text(
              'Resultado: $result',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

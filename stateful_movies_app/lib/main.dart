import 'package:flutter/material.dart';
import '/screens/screens.dart';

void main() {
  runApp(const StatefulMoviesApp());
}

class StatefulMoviesApp extends StatelessWidget {
  const StatefulMoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const FutureBuilderScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _numPeliculas = '0';

  @override
  void initState() {
    super.initState();
    getMovies();
  }

  void getMovies() async {
    var url = Uri.https('api.themoviedb.org', '/3/movie/popular', {
      'q': '{http}',
      'api_key': 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
      'language': 'en-US',
      'page': '1',
    });

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      // Se obtuvo una respuesta favorable.
      await Future<String>.delayed(const Duration(seconds: 10), () => 'Data Loaded');

      if (kDebugMode) {
        setState(() {
          _numPeliculas = jsonResponse['total_results'].toString();
        });
        print(jsonResponse);
      }
    } else {
      if (kDebugMode) {
        print('Request failed with status: ${response.statusCode}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.headlineMedium;

    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: const Text('HomeScreen')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(child: Text('Películas: $_numPeliculas', style: textStyle)),
          Center(child: Text('HomeScreen', style: textStyle)),
        ],
      ),
    );
  }
}

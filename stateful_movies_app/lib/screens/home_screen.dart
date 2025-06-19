// Importo el paquete principal de Flutter para poder construir la interfaz gráfica.
import 'package:flutter/material.dart';

// Este lo uso por si quiero imprimir cosas en consola solo cuando estoy en modo debug.
import 'package:flutter/foundation.dart';

// Para poder convertir la respuesta de la API (que es JSON) a objetos que pueda usar.
import 'dart:convert' as convert;

// Y este paquete es para hacer peticiones HTTP a la API de películas.
import 'package:http/http.dart' as http;

// Pantalla que estoy usando como inicio o pantalla principal.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// Esta es la clase que contiene el estado de la pantalla (porque uso StatefulWidget).
class _HomeScreenState extends State<HomeScreen> {
  // Variable donde voy a guardar cuántas películas me regresó la API.
  String _numPeliculas = '0';

  // Esta función se ejecuta automáticamente cuando se crea la pantalla.
  @override
  void initState() {
    super.initState();
    getMovies(); // Aquí llamo a mi función que va a pedir las películas.
  }

  // Esta función es la que se encarga de conectarse a la API y obtener datos.
  void getMovies() async {
    // Aquí armo la URL a la que le voy a hacer la solicitud.
    var url = Uri.https('api.themoviedb.org', '/3/movie/popular', {
      'q': '{http}', // Este parámetro realmente no se necesita, pero está aquí.
      'api_key': '0329a1cf1c09e444b8edec2a3155c01c', // Mi API Key de TMDb.
      'language': 'en-US', // Idioma de los resultados.
      'page': '1', // Página 1 de los resultados.
    });

    // Hago la solicitud GET a la URL que armé.
    var response = await http.get(url);

    // Verifico que la respuesta haya sido exitosa (código 200).
    if (response.statusCode == 200) {
      // Decodifico el cuerpo de la respuesta (que viene en JSON).
      var jsonResponse = convert.jsonDecode(response.body);

      // Esto solo es para simular una espera de 10 segundos.
      await Future<String>.delayed(
          const Duration(seconds: 10), () => 'Data Loaded');

      // Si estoy en modo debug, muestro los resultados y actualizo el estado.
      if (kDebugMode) {
        setState(() {
          // Aquí extraigo el número total de películas y lo muestro en pantalla.
          _numPeliculas = jsonResponse['total_results'].toString();
        });
        print(jsonResponse); // También imprimo toda la respuesta en la consola.
      }
    } else {
      // Si la respuesta no fue exitosa, imprimo el error en consola (si estoy en debug).
      if (kDebugMode) {
        print('Request failed with status: ${response.statusCode}');
      }
    }
  }

  // Esta parte construye la interfaz visual que se muestra en pantalla.
  @override
  Widget build(BuildContext context) {
    // Estilo de texto que viene del tema que use en toda la app.
    final textStyle = Theme.of(context).textTheme.headlineMedium;

    return Scaffold(
      // AppBar que se muestra arriba, con título y color.
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('HomeScreen'),
      ),
      // El cuerpo de la pantalla va a tener dos textos centrados en una columna.
      body: Column(
        mainAxisAlignment:
            MainAxisAlignment.spaceAround, // Espacio entre elementos.
        children: [
          // Aquí muestro cuántas películas me regresó la API.
          Center(child: Text('Películas: $_numPeliculas', style: textStyle)),

          // Solo un texto adicional para saber que estoy en esta pantalla.
          Center(child: Text('HomeScreen', style: textStyle)),
        ],
      ),
    );
  }
}

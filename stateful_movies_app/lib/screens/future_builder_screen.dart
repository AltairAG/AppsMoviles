// Importa la biblioteca principal de Flutter para construir interfaces gráficas.
import 'package:flutter/material.dart';

// Importa la biblioteca para hacer peticiones HTTP a la API de películas.
import 'package:http/http.dart' as http;

// Importa los modelos que contienen la estructura de los datos de películas (Movie, NowPlayingResponse).
import '../models/models.dart';

// Importa herramientas para trabajar con JSON (decodificar respuesta de la API).
import 'dart:convert';

// Declaramos una pantalla con estado que se llamará FutureBuilderScreen.
class FutureBuilderScreen extends StatefulWidget {
  const FutureBuilderScreen({super.key}); // Constructor con clave opcional.

  // Crea el estado asociado a este widget.
  @override
  State<FutureBuilderScreen> createState() => _FutureBuilderScreenState();
}

// Estado de la pantalla FutureBuilderScreen.
class _FutureBuilderScreenState extends State<FutureBuilderScreen> {
  // Declaramos una variable Future que contendrá la respuesta de la API.
  late Future<NowPlayingResponse?> response;

  // Método que se ejecuta automáticamente al inicializar el widget.
  @override
  void initState() {
    super.initState(); // Llama al initState original de la clase padre.
    response = getNowPlaying(); // Inicia la llamada a la API.
  }

  // Función asincrónica que obtiene las películas actualmente en cartelera.
  Future<NowPlayingResponse?> getNowPlaying() async {
    // Construye la URL para hacer la petición a la API de TMDb.
    var url = Uri.https('api.themoviedb.org', '/3/movie/now_playing', {
      'api_key':
          '0329a1cf1c09e444b8edec2a3155c01c', // Clave de API personalizada.
      'language': 'es-MX', // Idioma en que se devuelven los resultados.
      'page': '1', // Página de resultados (por si hay más de 20 películas).
    });

    // Ejecuta la solicitud GET a la API.
    var response = await http.get(url);

    // Si el código de respuesta es 200 (éxito), procesa el JSON.
    if (response.statusCode == 200) {
      // Convierte el cuerpo de la respuesta a un objeto NowPlayingResponse.
      return NowPlayingResponse.fromJson(response.body);
    } else {
      // Si hay error en la solicitud, retorna null.
      return null;
    }
  }

  // Método que construye la interfaz visual.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar de la aplicación con el título y color definido por el tema.
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Aplicación Películas'),
      ),

      // Cuerpo principal de la app. Usamos un FutureBuilder para esperar datos de la API.
      body: FutureBuilder(
        future: response, // El future a esperar (películas desde la API).
        builder: (BuildContext context,
            AsyncSnapshot<NowPlayingResponse?> snapshot) {
          // Si el Future todavía está esperando (en progreso), muestra un indicador de carga.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child:
                  CircularProgressIndicator(), // Indicador de progreso circular.
            );
          }

          // Si ocurrió un error o no hay datos, muestra mensaje de error.
          if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Text(
                  'Error al cargar películas: ${snapshot.error}'), // Muestra el error.
            );
          }

          // Si todo salió bien, extrae la lista de películas.
          final movies = snapshot.data!.results;

          // Crea una lista desplazable (scrollable) con todas las películas.
          return ListView.builder(
            itemCount: movies.length, // Número de elementos a mostrar.
            itemBuilder: (context, index) {
              final movie = movies[index]; // Película actual.

              // Retorna una tarjeta por cada película con su imagen, nombre y popularidad.
              return Card(
                margin: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 6), // Espaciado externo.
                child: ListTile(
                  // Imagen del póster, si no hay imagen se muestra una por defecto.
                  leading: Image.network(
                    movie.fullPosterImg, // URL completa del póster.
                    width: 50, // Ancho de la imagen.
                    fit:
                        BoxFit.cover, // Ajusta la imagen al espacio disponible.
                  ),
                  title: Text(movie.title), // Título de la película.
                  subtitle: Text(
                    'Popularidad: ${movie.popularity.toStringAsFixed(1)}', // Popularidad formateada.
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

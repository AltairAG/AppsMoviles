// Importamos el paquete material.dart que contiene los widgets básicos de Flutter
import 'package:flutter/material.dart';

// Importamos el paquete provider para manejar el estado de la aplicación
import 'package:provider/provider.dart';

// Importamos nuestro archivo que maneja la lógica de ubicación
import 'providers/location_provider.dart';

// Importamos la pantalla principal del mapa
import 'screens/map_screen.dart';

// Función principal que se ejecuta al iniciar la app
void main() {
  // runApp es la función que inicia la aplicación Flutter
  runApp(
    // ChangeNotifierProvider nos permite proveer datos a toda la app
    ChangeNotifierProvider(
      // Creamos una instancia de nuestro controlador de ubicación
      create: (context) => LocationController(),
      // MyApp es el widget raíz de nuestra aplicación
      child: const MyApp(),
    ),
  );
}

// Definición de nuestra aplicación principal
class MyApp extends StatelessWidget {
  // Constructor con key opcional
  const MyApp({super.key});

  // Método build que define cómo se construye nuestro widget
  @override
  Widget build(BuildContext context) {
    // MaterialApp es el widget que configura toda la aplicación
    return MaterialApp(
      // Título de la aplicación
      title: 'Ubicación con Mapa',
      // Quitamos la etiqueta de debug en la esquina superior derecha
      debugShowCheckedModeBanner: false,
      // Configuración del tema visual de la app
      theme: ThemeData(
        // Definimos un esquema de colores basado en naranja
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        // Habilitamos Material 3 (diseño más moderno)
        useMaterial3: true,
      ),
      // Definimos la pantalla inicial de la aplicación
      home: const MapScreen(), // MapScreen será lo primero que vea el usuario
    );
  }
}
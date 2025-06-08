import 'package:flutter/material.dart'; // Biblioteca base de Flutter para widgets y UI.
import 'package:provider/provider.dart'; // Para gestión de estado con Provider.
import 'package:register_login/pages/login_page.dart'; // Página de inicio de sesión.
import 'package:register_login/pages/register_page.dart'; // Página de registro.
import 'package:register_login/state/app_state.dart'; // Estado global de la app.

// Función principal que inicia la aplicación.
void main() {
  runApp(
    // Proveemos el estado global (`AppState`) a toda la app usando `ChangeNotifierProvider`.
    ChangeNotifierProvider(
      create: (_) =>
          AppState(), // Crea una instancia de `AppState` (gestor de estado).
      child: const MyApp(), // Inicia la app con el widget raíz `MyApp`.
    ),
  );
}

// Widget principal de la aplicación (Stateless porque no maneja estado interno).
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Constructor con clave opcional.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, // Oculta la etiqueta "Debug" en esquina superior derecha.
      title: 'Login-Register', // Título de la app (para el sistema operativo).
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ), // Define el tema visual como color primario azul.
      home: Consumer<AppState>(
        // Widget que escucha cambios en `AppState` y reconstruye su hijo.
        builder: (context, state, _) {
          // Decide qué página mostrar según el valor de `state.view`:
          // - Si es `AppView.login`, muestra `LoginPage()`.
          // - Si no, muestra `RegisterPage()`.
          return state.view == AppView.login ? LoginPage() : RegisterPage();
        },
      ),
    );
  }
}

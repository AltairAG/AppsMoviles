// Importamos el paquete material de Flutter para usar ChangeNotifier
import 'package:flutter/material.dart';

// Definimos un enumerado para las vistas/páginas disponibles en la app
enum AppView {
  login, // Pantalla de inicio de sesión
  register, // Pantalla de registro
}

// Clase que maneja el estado global de la aplicación (hereda de ChangeNotifier)
class AppState extends ChangeNotifier {
  AppView _view = AppView
      .login; // Variable privada que guarda la vista actual (inicia en login por defecto)
  AppView get view =>
      _view; // Getter público para leer la vista actual desde otros widgets

  // Método para cambiar a la vista de login
  void goToLogin() {
    _view = AppView.login; // Actualiza el estado interno
    notifyListeners(); // Avisa a todos los widgets escuchando que hubo un cambio
  }

  // Método para cambiar a la vista de registro
  void goToRegister() {
    _view = AppView.register; // Actualiza el estado interno
    notifyListeners(); // Notifica a los widgets suscritos
  }
}

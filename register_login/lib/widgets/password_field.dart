// Importamos el paquete material de Flutter para usar widgets básicos
import 'package:flutter/material.dart';

// Widget para campo de contraseña con funcionalidad para mostrar/ocultar texto
class PasswordField extends StatefulWidget {
  // Parámetros que podemos personalizar al usar este widget:
  final TextEditingController
  controller; // Controlador para manejar el texto ingresado
  final String hintText; // Texto de ayuda (placeholder)

  // Constructor - 'required' obliga a pasar el controller al usar el widget
  const PasswordField({
    super.key, // Clave única para identificar el widget en el árbol
    required this.controller, // Controller es obligatorio
    this.hintText = "Password", // Valor por defecto si no se especifica
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

// Clase que maneja el estado interno del widget (para mostrar/ocultar contraseña)
class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true; // Controla si el texto está oculto (****) o visible

  @override
  Widget build(BuildContext context) {
    // Configuración del borde del campo de texto
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18), // Bordes redondeados
      borderSide: const BorderSide(color: Colors.white), // Borde blanco
    );

    // Campo de texto base con funcionalidad especial para contraseñas
    return TextField(
      controller: widget.controller, // Vinculamos el controlador recibido
      obscureText: _obscureText, // Oculta o muestra el texto según el estado
      style: const TextStyle(color: Colors.white), // Color del texto ingresado
      decoration: InputDecoration(
        hintText: widget.hintText, // Muestra el texto de ayuda recibido
        hintStyle: const TextStyle(
          color: Colors.white,
        ), // Color del texto de ayuda
        enabledBorder: border, // Borde cuando el campo no está seleccionado
        focusedBorder: border, // Borde cuando el campo está seleccionado
        suffixIcon: IconButton(
          // Botón a la derecha del campo (ojo)
          icon: Icon(
            // Cambia entre iconos de ojo abierto/cerrado según el estado
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.white, // Color blanco para el ícono
          ),
          onPressed: () {
            // Al presionar el botón, cambiamos el estado para mostrar/ocultar texto
            setState(() {
              _obscureText = !_obscureText; // Invierte el valor actual
            });
          },
        ),
      ),
    );
  }
}

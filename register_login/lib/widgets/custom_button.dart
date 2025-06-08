// Importamos el paquete material de Flutter para usar widgets básicos como ElevatedButton
import 'package:flutter/material.dart';

// Definimos un botón personalizado como StatelessWidget (no cambia su estado interno)
class CustomButton extends StatelessWidget {
  // Propiedades que podemos personalizar al usar este botón:
  final String text; // Texto que mostrará el botón (requerido)
  final VoidCallback
  onPressed; // Función que se ejecutará al presionar (requerido)

  // Constructor del botón. Usamos Key? para manejar identificadores únicos en el árbol de widgets
  const CustomButton({
    Key? key,
    required this.text, // 'required' obliga a pasar estos parámetros
    required this.onPressed,
  }) : super(key: key); // Pasamos la key al constructor padre

  @override
  Widget build(BuildContext context) {
    // Usamos ElevatedButton por su estilo moderno con sombra
    return ElevatedButton(
      onPressed: onPressed, // Asignamos la función que nos pasaron al presionar
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(), // Forma ovalada (como un estadio)
        backgroundColor: const Color(0xFFFFFFFF), // Fondo blanco
        foregroundColor: const Color(0xFF2196F3), // letra azul
        //backgroundColor: const Color(0xFFe4c747), // Fondo amarillo
        //foregroundColor: const Color(0xFF351b4b), // letra morada
        padding: const EdgeInsets.symmetric(
          vertical: 10, // Espacio arriba/abajo del texto
          horizontal: 10, // Espacio izquierda/derecha del texto
        ),
      ),
      // El contenido del botón es un SizedBox con un Text centrado
      child: SizedBox(
        width: 100, // Ancho fijo para consistencia entre botones
        child: Text(
          text, // Mostramos el texto que nos pasaron
          textAlign: TextAlign.center, // Centra el texto horizontalmente
          style: const TextStyle(
            fontSize: 15, // Tamaño de letra
          ),
        ),
      ),
    );
  }
}

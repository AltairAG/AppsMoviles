// Importamos el paquete material de Flutter para usar widgets básicos
import 'package:flutter/material.dart';

// Widget que muestra un icono de usuario dentro de un círculo
class UserIcon extends StatelessWidget {
  // Propiedades configurables:
  final IconData
  iconData; // Tipo de icono a mostrar (por defecto: Icons.person)
  final double size; // Tamaño total del componente (incluyendo el borde)

  // Constructor con valores por defecto:
  const UserIcon({
    Key? key, // Clave opcional para identificar el widget en el árbol
    this.iconData =
        Icons.person, // Si no se especifica, usa el icono de persona
    this.size = 120, // Tamaño por defecto de 120 píxeles
  }) : super(key: key); // Pasamos la clave al constructor padre

  @override
  Widget build(BuildContext context) {
    return Container(
      // Decoración del contenedor (el círculo con borde):
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFFFFFFF), // Color del borde
          width: 2, // Grosor del borde (2 píxeles)
        ),
        shape: BoxShape
            .circle, // Forma circular (importante para el borde redondeado)
      ),
      // El contenido del contenedor es un Icono con padding:
      child: Padding(
        // Padding proporcional al tamaño (10% del tamaño total):
        padding: EdgeInsets.all(size * 0.1),
        // Icono principal (80% del tamaño total para que quepa con el padding):
        child: Icon(
          iconData, // Icono que recibimos por parámetro
          color: Colors.white, // Color blanco para el icono
          size: size * 0.8, // Tamaño del icono (80% del tamaño total)
        ),
      ),
    );
  }
}

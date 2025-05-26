// Importamos los paquetes necesarios
import 'package:flutter/material.dart';          // Para los widgets básicos
import 'package:provider/provider.dart';        // Para acceder al estado de la app
import '../providers/location_provider.dart';   // Donde tenemos la lógica del GPS

// Este es nuestro marcador personalizado que muestra la ubicación
class LocationMarker extends StatelessWidget {
  const LocationMarker({super.key});  // Constructor simple

  @override
  Widget build(BuildContext context) {
    // Obtenemos la ubicación actual del provider
    // El ! es para decirle a Dart "confía, esto no será nulo"
    final location = Provider.of<LocationController>(context).currentPosition!;
    
    // Usamos una Columna para apilar texto arriba e icono abajo
    return Column(
      mainAxisSize: MainAxisSize.min,  // Que ocupe sólo el espacio necesario
      children: [
        // Contenedor blanco para las coordenadas
        Container(
          constraints: const BoxConstraints(maxWidth: 110),  // Ancho máximo
          padding: const EdgeInsets.symmetric(  // Relleno interno
            horizontal: 6,  // Izquierda/derecha
            vertical: 3,    // Arriba/abajo
          ),
          decoration: BoxDecoration(
            color: Colors.white,  // Fondo blanco
            borderRadius: BorderRadius.circular(4),  // Esquinas redondeadas
            boxShadow: [  // Sombra para que resalte
              BoxShadow(
                color: Colors.black.withOpacity(0.2),  // Color semi-transparente
                blurRadius: 2,    // Qué tan difuminada
                offset: const Offset(0, 1),  // Posición de la sombra (abajo)
              ),
            ],
          ),
          // El texto de las coordenadas que se ajusta automáticamente
          child: FittedBox(
            child: Text(
              // Mostramos latitud y longitud con 5 decimales
              '${location.latitude.toStringAsFixed(5)}\n'  // \n es salto de línea
              '${location.longitude.toStringAsFixed(5)}',
              textAlign: TextAlign.center,  // Texto centrado
              style: const TextStyle(
                fontSize: 10,    // Tamaño pequeño
                color: Colors.black,  // Letras negras
                fontWeight: FontWeight.bold,  // Negritas
              ),
            ),
          ),
        ),
        
        // Espacio entre el texto y el icono
        const SizedBox(height: 4),
        
        // El icono de ubicación (el puntito rojo)
        const Icon(
          Icons.location_pin,  // Icono de ubicación
          color: Colors.red,   // Color rojo
          size: 30,            // Tamaño mediano
        ),
      ],
    );
  }
}
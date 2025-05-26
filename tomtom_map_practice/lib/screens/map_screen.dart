// Paquetes necesarios para el mapa
import 'package:flutter/material.dart';          // Para la interfaz básica
import 'package:flutter_map/flutter_map.dart';   // Para mostrar el mapa interactivo
import 'package:latlong2/latlong.dart';         // Para trabajar con coordenadas (lat, long)
import 'package:provider/provider.dart';         // Para acceder al estado de la app

// Nuestros propios archivos
import '../providers/location_provider.dart';    // Donde guardamos la lógica del GPS
import '../widgets/location_marker.dart';        // El marcador personalizado que creamos

// Esta es la pantalla principal con el mapa
class MapScreen extends StatelessWidget {
  const MapScreen({super.key});  // Constructor básico

  @override
  Widget build(BuildContext context) {
    // Accedemos al controlador de ubicación que creamos
    final locationCtrl = Provider.of<LocationController>(context);
    
    // Este controlador nos permite mover el mapa programáticamente
    final mapController = MapController();
    
    // La llave para usar TomTom (¡OJO! No debería estar aquí en una app real)
    const apiKey = 'ItM29rLmD4sqUc3YPLd3E024Pg6Up6gs';

    // Si tenemos una ubicación guardada, centramos el mapa ahí
    if (locationCtrl.currentPosition != null) {
      // Esperamos a que el mapa esté listo antes de moverlo
      WidgetsBinding.instance.addPostFrameCallback((_) {
        mapController.move(locationCtrl.currentPosition!, 15.0); // Zoom 15
      });
    }

    // La estructura básica de la pantalla
    return Scaffold(
      // Barra superior con título
      appBar: AppBar(title: const Text('Mi Ubicación')),
      
      // El cuerpo con Stack nos permite poner cosas encima del mapa
      body: Stack(
        children: [
          // El mapa en sí
          FlutterMap(
            mapController: mapController,  // Para controlar el mapa
            options: MapOptions(
              center: LatLng(19.4326, -99.1332),  // Centro inicial (CDMX)
              zoom: 15.0,  // Nivel de zoom inicial
            ),
            children: [
              // Las imágenes del mapa (los "baldosos")
              TileLayer(
                urlTemplate: 'https://api.tomtom.com/map/1/tile/basic/main/{z}/{x}/{y}.png?key={apiKey}',
                additionalOptions: {'apiKey': apiKey},
              ),
              
              // Si tenemos ubicación, mostramos el marcador
              if (locationCtrl.currentPosition != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: locationCtrl.currentPosition!,  // Coordenadas
                      width: 120,   // Ancho del marcador
                      height: 80,   // Alto del marcador
                      builder: (ctx) => const LocationMarker(),  // Nuestro diseño personalizado
                    ),
                  ],
                ),
            ],
          ),
          
          // Botón flotante como en Google Maps
          Positioned(
            bottom: 20,  // 20 pixeles desde abajo
            right: 20,   // 20 pixeles desde la derecha
            child: FloatingActionButton(
              mini: true,  // Más pequeño que el normal
              backgroundColor: Colors.white,  // Fondo blanco
              onPressed: () {
                // Al presionar, pedimos la ubicación actual
                locationCtrl.getCurrentLocation();
                
                // Si hubo error, mostramos un mensaje
                if (locationCtrl.error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(locationCtrl.error!)),
                  );
                }
              },
              child: const Icon(Icons.gps_fixed, color: Colors.black),  // Icono de GPS
            ),
          ),
        ],
      ),
    );
  }
}
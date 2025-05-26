// Paquetes que necesitamos para que esto funcione
import 'package:flutter/material.dart';  // Para los widgets básicos
import 'package:latlong2/latlong.dart';  // Para manejar coordenadas (latitud, longitud)
import 'package:location/location.dart'; // Para acceder al GPS del teléfono

// Esta clase maneja todo lo relacionado con la ubicación
class LocationController with ChangeNotifier {
  // El objeto que nos permite acceder al GPS
  final Location _location = Location();
  
  // Aquí guardamos la posición actual (lat, long)
  LatLng? _currentPosition;
  
  // Por si algo sale mal, guardamos el error aquí
  String? _error;

  // Para poder ver la posición desde otras partes del código
  LatLng? get currentPosition => _currentPosition;
  
  // Para ver si hubo algún error
  String? get error => _error;

  // Esto es lo que se ejecuta cuando pedimos la ubicación
  Future<void> getCurrentLocation() async {
    try {
      // Primero: Ver si el GPS está activado
      bool gpsActivo = await _location.serviceEnabled();
      if (!gpsActivo) {
        // Si no está activo, lo pedimos
        gpsActivo = await _location.requestService();
        if (!gpsActivo) throw 'El GPS está apagado'; // Si no quieren activarlo, lanzamos error
      }

      // Segundo: Verificar permisos
      var permisos = await _location.hasPermission();
      if (permisos == PermissionStatus.denied) {
        // Si no tenemos permiso, lo solicitamos
        permisos = await _location.requestPermission();
        if (permisos != PermissionStatus.granted) throw 'No nos dieron permiso';
      }

      // Tercero: Si todo está bien, obtenemos la ubicación
      final ubicacion = await _location.getLocation();
      _currentPosition = LatLng(ubicacion.latitude!, ubicacion.longitude!);
      _error = null; // Limpiamos cualquier error anterior
    } catch (e) {
      // Si algo falla, guardamos el error
      _error = e.toString();
      debugPrint('Error de ubicación: $_error'); // Esto aparece en la consola
    } finally {
      // Avisamos a todos los que estén escuchando que hubo cambios
      notifyListeners();
    }
  }
}
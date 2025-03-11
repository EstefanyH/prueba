import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  /// Verifica y solicita el permiso de cámara
  Future<bool> requestCameraPermission(BuildContext context) async {
    var status = await Permission.camera.status;

    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Solicitando permiso de cámara... 📸")),
      );

      status = await Permission.camera.request();

      if (status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Permiso de cámara concedido ✅")),
        );
        return true;
      } else if (status.isDenied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Permiso de cámara denegado ❌")),
        );
        return false;
      } else if (status.isPermanentlyDenied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Permiso de cámara bloqueado. Habilítalo en configuración ⚠️"),
            action: SnackBarAction(
              label: "Abrir configuración",
              onPressed: () {
                openAppSettings(); // Abre la configuración del sistema
              },
            ),
          ),
        );
        return false;
      }
    }
    return true;
  }

  /// Verifica y solicita el permiso de galería (almacenamiento en Android)
  Future<bool> requestGalleryPermission() async {
    final status = await Permission.photos.request();
    return status.isGranted;
  }

  /// Verifica y solicita múltiples permisos (útil para la pantalla inicial)
  Future<bool> requestAllPermissions() async {
    final statuses = await [
      Permission.camera,
      Permission.photos,
    ].request();

    return statuses.values.every((status) => status.isGranted);
  } 

  static Future<bool> isLocationServiceEnabled() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('El servicio de ubicación no está habilitado');
      return false;
    }
    return true;
  }

  // Verificar si los permisos de ubicación están concedidos
  static Future<LocationPermission> checkPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    return permission;
  }

  // Solicitar permisos de ubicación si no están concedidos
  static Future<LocationPermission> requestPermissions() async {
    LocationPermission permission = await Geolocator.requestPermission();
    return permission;
  }

  // Función que encapsula todo el proceso de verificación y solicitud de permisos
  static Future<bool> checkAndRequestPermissions() async {
    bool serviceEnabled = await isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;  // Si el servicio no está habilitado, no hay nada más que hacer
    }

    LocationPermission permission = await checkPermissions();
    if (permission == LocationPermission.denied) {
      permission = await requestPermissions();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        print('Los permisos de ubicación no fueron concedidos');
        return false;
      }
    }
    return true;  // Los permisos son válidos
  }

static Future<bool> isInternetAvailable() async {
    try {
      // Realizamos una solicitud HTTP a Google (un servidor confiable)
      final response = await http.get(Uri.parse('https://www.google.com'));

      // Si la respuesta es exitosa (código 200), significa que hay Internet
      if (response.statusCode == 200) {
        print('Conexión a Internet disponible');
        return true;
      } else {
        print('No se pudo acceder a Internet');
        return false;
      }
    } catch (e) {
      print('Error al intentar conectarse a Internet: $e');
      return false;
    }
  }
}
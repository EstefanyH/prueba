import 'package:flutter/material.dart';
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
}
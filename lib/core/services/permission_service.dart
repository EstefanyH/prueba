import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  /// Verifica y solicita el permiso de cámara
  Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
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
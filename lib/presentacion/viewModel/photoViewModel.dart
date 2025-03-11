import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prueba/core/baseViewModel.dart';
import 'package:prueba/core/services/camera_service.dart';
import 'package:prueba/core/services/permission_service.dart';
import 'package:prueba/core/service_locator.dart';
import 'package:prueba/core/util/callback.dart';
import 'package:prueba/core/widgets/camera.dart';
import 'package:prueba/domain/enums/app_Enums.dart';
import 'package:prueba/domain/repository/photo.repository.dart';

class PhotoViewModel extends BaseViewModel with ChangeNotifier {
  final PhotoRepository repository;
  
  final PermissionService _permissionService = sl<PermissionService>();
  final CameraService _cameraService = sl<CameraService>();

  XFile? _image1File;
  XFile? get image1File => _image1File;

  XFile? _image2File;
  XFile? get image2File => _image2File;

  XFile? _image3File;
  XFile? get image3File => _image3File;


  PhotoViewModel({required this.repository});

  Future<void> onSave (BuildContext ctx) async{
    try {
      repository.postSaveData();
      showMessage(ctx, 'Operación exitosa');
    } catch (xe ) {
      showMessage(ctx, 'Ocurrió un error intentar mas rato');
    }
  }

  Future<void> onShowOpenModal(BuildContext ctx, PhotoSide type) async {
    showModalCamera(ctx, 
      eventInterface: EventInterface(onItemSelected: (context, i, selectedItem) async {        
        await _openCamera(ctx, type); 
    }));
  }

  Future<void> _openCamera(BuildContext ctx, PhotoSide type) async {
    try {
      bool hasPermission = await _permissionService.requestCameraPermission(ctx);

      final image = await _cameraService.openCamera();
      if (image != null) {
        print(image);
        print(image!.path);

        switch(type){
          case PhotoSide.front: 
            _image1File = image;
            break;
          case PhotoSide.left:
            _image2File = image;
          break;
          case PhotoSide.right: break;
        }

        notifyListeners(); // Notifica cambios a la UI

        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(content: Text("Imagen capturada exitosamente ✅")),
        );
      } else {
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(content: Text("No se capturó ninguna imagen ❌")),
        );
      }
    } catch( xe){
      print(xe);

    }
     

  }


}
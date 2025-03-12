import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prueba/core/baseViewModel.dart';
import 'package:prueba/core/services/camera_service.dart';
import 'package:prueba/core/services/permission_service.dart';
import 'package:prueba/core/service_locator.dart';
import 'package:prueba/core/util/callback.dart';
import 'package:prueba/core/widgets/camera.dart';
import 'package:prueba/data/model/photo.model.dart';
import 'package:prueba/domain/entities/cia.dart';
import 'package:prueba/domain/entities/type_photo.dart';
import 'package:prueba/domain/enums/app_Enums.dart';
import 'package:prueba/domain/repository/photo.repository.dart';

class PhotoViewModel extends BaseViewModel with ChangeNotifier {
  final PhotoRepository repository;
  
  final PermissionService _permissionService = sl<PermissionService>();
  final CameraService _cameraService = sl<CameraService>();
  
  final ImagePicker _picker = ImagePicker();
  File? _imageFile; 

  List<File?> _imageFiles = [];
  List<File?> get imageFiles => _imageFiles;

  List<TypePhoto> types = [];
  List<PhotoModel> photos = [];

  String _ruc = '111';

  PhotoViewModel({required this.repository});

  Future<void> init(BuildContext ctx) async {
    try {
      types = await repository.getAllType();
       
      for ( var i = 0; i <  types.length ; i++ ) {
          _imageFiles.add(_imageFile);  // Agregar la imagen a la lista
        }

      notifyListeners();
    } catch(xe){
      showMessage(ctx,'Ocurrió un error inesperado, intentar mas rato');
    }
  }

  Future<void> onSave (BuildContext ctx) async{
    bool valid = false;
    try {
      /*
      var model = await repository.getCia();
      if (model == null) {
        showMessage(ctx, 'Completar datos de restaurante');
      } else {
         valid = isValid(ctx, model);
        if (valid){
          bool isconnect = await PermissionService.isInternetAvailable();

          valid = await repository.postSaveData(isconnect);
          if (valid) showMessage(ctx, 'Operación exitosa');
          else showMessage(ctx, 'Ocurrió un error intentar mas rato');
        }
      }*/
      //var model = PhotoModel(ruc: _ruc, archivo: '${_ruc}_1', tipo: , ruta: _imageFile?.path ?? '');
      bool result = false;
      for(var model in photos){
        result = await repository.postSavePhoto(model);
      }

      if (result) showMessage(ctx, 'Se guardo con exito');
      else showMessage(ctx, 'Ocurrió un error intentar mas rato');
    } catch (xe ) {
      showMessage(ctx, 'Ocurrió un error intentar mas rato');
    }
  }

  bool isValid(BuildContext ctx, Cia model) {
    if(model.name.isEmpty) {
      showMessage(ctx, 'Ingresar nombre');
      return false;
    }
    if(model.ruc.isEmpty) {
      showMessage(ctx, 'Ingresar nombre');
      return false;
    }
    return true;
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
            //_image1File = image;
            break;
          case PhotoSide.left:
            //_image2File = image;
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

  Future<void> takePhoto(BuildContext ctx, int i, String id) async {
    try {
      /*
      bool hasPermission = await _permissionService.requestCameraPermission(ctx);
      
      if (!hasPermission) {
        showMessage(ctx, 'Permiso de cámara denegado ❌')
        return;
      } */
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (!photos.isNotEmpty) photos.removeWhere((c) => c.ruc == _ruc && c.tipo == id );

      if (pickedFile != null) {
        print(pickedFile.path);
        
        _imageFile = File(pickedFile.path);
        _imageFiles[i] = _imageFile;

        var photo = PhotoModel(ruc: _ruc, archivo: '${_ruc}_${id}', tipo: id, ruta: _imageFile?.path ?? '');
        photos.add(photo);

        notifyListeners(); // Notifica a la UI que hay una nueva imagen
      } else {
        _showError(ctx, "No se tomó ninguna foto.");
      }
    } catch (e) {
      print("Error al abrir la cámara: $e");
      _showError(ctx, "Error al abrir la cámara.");
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message, style: TextStyle(color: Colors.white)), backgroundColor: Colors.red),
    );
  }


}
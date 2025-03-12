import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
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

import 'package:path/path.dart' as p;

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

  String _ruc = '';
  Cia? _cia;

  PhotoViewModel({required this.repository});

  Future<void> init(BuildContext ctx) async {
    try {
      await clear();

      _cia = await repository.getCia();

      if (_cia != null){
        _ruc = _cia?.ruc ?? '';  
      }  
      
      notifyListeners();

      if(_ruc.isEmpty) showMessage(ctx, 'Completar datos del restaurante');
      
    } catch(xe){
      showMessage(ctx,'Ocurrió un error inesperado, intentar mas rato');
    }
  }

  Future<void> onSave (BuildContext ctx) async{
    
    showLoading();
    bool valid = false;
    try {
      if (photos.length == 3){
        var model = await repository.getCia();
        if (model == null) {
          showMessage(ctx, 'Completar datos de restaurante');
        } else {
          valid = isValid(ctx, model);
          if (valid){
            bool isconnect = await PermissionService.isInternetAvailable();

            valid = await repository.postSaveData(isconnect, photos);
            if (valid) {
              clear();
              showMessage(ctx, 'Operación exitosa');
            }else showMessage(ctx, 'Ocurrió un error intentar mas rato');
          }
        }
      } else showMessage(ctx, 'Falta agregar fotos');
      notifyListeners();
    } catch (xe ) {
      showMessage(ctx, 'Ocurrió un error intentar mas rato');
    }

      hideLoading();
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
    if (model.latitude.isEmpty){
      showMessage(ctx, 'Ingresar latitud');
      return false;
    }
    if (model.longitude.isEmpty){
      showMessage(ctx, 'Ingresar longitud');
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

  Future<void> takePhoto(BuildContext ctx, int i, String tipo) async {
    try {
      /*
      bool hasPermission = await _permissionService.requestCameraPermission(ctx);
      
      if (!hasPermission) {
        showMessage(ctx, 'Permiso de cámara denegado ❌')
        return;
      } */

      if (_ruc != '') {

        final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

        if (!photos.isNotEmpty) photos.removeWhere((c) => c.ruc == _ruc && c.tipo == tipo );

        if (pickedFile != null) {
          print(pickedFile.path);
          
          _imageFile = File(pickedFile.path);
          _imageFiles[i] = _imageFile;


          DateTime now = DateTime.now();
          String formattedDateTime = "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}"
          "${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}";

          print('fecha: ${formattedDateTime}');

          //Directory tempDir = await getTemporaryDirectory();
          final tempDir = await getApplicationDocumentsDirectory();
          final folderName = 'tempFolder';
          final newFolderPath = '${tempDir.path}/$folderName';
          final basename =  '${formattedDateTime}.jpg';
          
          print('carpeta: ${newFolderPath}');

          final newFolder = Directory(newFolderPath);

          if (!await newFolder.exists()) {
              // Si no existe, crearla
              await newFolder.create();    
          }

          final newruta = p.join(newFolderPath, basename);

          print('ruta: ${newruta}');

          await _imageFile?.copy(newruta);

          //var photo = PhotoModel(ruc: _ruc, archivo: '${_ruc}_${id}', tipo: id, ruta: _imageFile?.path ?? '');
          var photo = PhotoModel(ruc: _ruc, archivo: '${_ruc}_${tipo}.jpg', tipo: tipo, ruta: newruta ?? '');
          photos.add(photo);

          notifyListeners(); // Notifica a la UI que hay una nueva imagen
        } else {
          _showError(ctx, "No se tomó ninguna foto.");
        }
      } else showMessage(ctx, 'Completar datos de restaurante');

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

  Future<void> clear() async{
    _ruc = '';
    types = [];
    _imageFile = null;
    _imageFiles = [];
    photos = [];

    types = await repository.getAllType();
      for ( var i = 0; i <  types.length ; i++ ) {
        _imageFiles.add(_imageFile);  // Agregar la imagen a la lista
    }
  }


}
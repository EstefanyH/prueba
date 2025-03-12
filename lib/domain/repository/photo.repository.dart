import 'package:prueba/data/model/photo.model.dart';
import 'package:prueba/domain/entities/cia.dart';
import 'package:prueba/domain/entities/type_photo.dart';

abstract class PhotoRepository {
  
  Future<Cia?> getCia();

  Future<bool> postSaveData(bool isconnect, List<PhotoModel> photos);

  Future<bool> postSavePhoto(PhotoModel model);

  Future<List<TypePhoto>> getAllType();
  
}
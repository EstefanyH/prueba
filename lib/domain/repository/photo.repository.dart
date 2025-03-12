import 'package:prueba/data/model/photo.model.dart';
import 'package:prueba/domain/entities/cia.dart';
import 'package:prueba/domain/entities/photo.dart';

abstract class PhotoRepository {
  
  Future<Cia?> getCia();

  Future<bool> postSaveData(bool isconnect);

  Future<bool> postSavePhoto(PhotoModel model);
  
}
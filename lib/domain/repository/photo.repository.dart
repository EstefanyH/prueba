import 'package:prueba/domain/entities/cia.dart';

abstract class PhotoRepository {
  
  Future<Cia?> getCia();

  Future<bool> postSaveData(bool isconnect);
  
}
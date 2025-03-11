import 'package:prueba/domain/entities/cia.dart';

abstract class PhotoRepository {
  
  Future<Cia?> getCia();

  Future<void> postSaveData(bool isconnect);
  
}
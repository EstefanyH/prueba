
import 'package:prueba/domain/entities/cia.dart';
import 'package:prueba/domain/entities/type_photo.dart';

abstract class HomeRepository {
  Future<bool> getListType();
  Future<int> getTotPending();
  Future<List<Cia>> getTotRegister();
  Future<List<TypePhoto>> getTypeLocal();

  Future<bool> getRegisterPending();
}
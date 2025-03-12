
import 'package:prueba/domain/entities/type_photo.dart';

abstract class HomeRepository {
  Future<bool> getListType();
  Future<int> getTotPending();
  Future<int> getTotRegister();
  Future<List<TypePhoto>> getTypeLocal();
}
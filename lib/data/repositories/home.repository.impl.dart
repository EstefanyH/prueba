import 'package:prueba/data/source/home.datasource.dart';
import 'package:prueba/domain/entities/type_photo.dart';
import 'package:prueba/domain/repository/home.repository.dart';

class HomeRepositoryImpl  implements HomeRepository {
  final HomeDatasource datasource;

  HomeRepositoryImpl({required this.datasource});
  
  @override
  Future<int> getTotPending() async {
    return await datasource.fetchTotPending();
  }
  
  @override
  Future<int> getTotRegister() async {
    return await datasource.fetchTotRegister();
  }
  
  @override
  Future<bool> getListType() async {
    return await datasource.fetchListType();
  }
}
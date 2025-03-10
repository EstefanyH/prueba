import 'package:prueba/data/source/home.datasource.dart';
import 'package:prueba/domain/repository/home.repository.dart';

class HomeRepositoryImpl  implements HomeRepository {
  final HomeDatasource datasource;

  HomeRepositoryImpl({required this.datasource});
}
import 'package:prueba/data/source/new.datasource.dart';
import 'package:prueba/domain/repository/new.repository.dart';

class NewRepositoryImpl extends NewRepository {
  final NewDatasource datasource;

  NewRepositoryImpl({required this.datasource});

}
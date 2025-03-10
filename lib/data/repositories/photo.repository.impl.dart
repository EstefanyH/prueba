import 'package:prueba/data/source/photo.datasource.dart';
import 'package:prueba/domain/repository/photo.repository.dart';

class PhotoRepositoryImpl extends PhotoRepository{
  final PhotoDatasource datasource;

  PhotoRepositoryImpl({required this.datasource});

}
import 'package:prueba/core/services/apiService.dart';

abstract class PhotoDatasource {

}

class PhotoDatasourceImpl extends PhotoDatasource {

  final ApiService api;

  PhotoDatasourceImpl({required this.api});
  

}
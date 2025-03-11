import 'package:prueba/core/api_config.dart';
import 'package:prueba/core/services/apiService.dart';
import 'package:prueba/data/model/cia.model.dart';
import 'package:prueba/data/model/response.model.dart';

abstract class PhotoDatasource {
  Future<bool> fetchNewCia(Map<String, dynamic> model);
}

class PhotoDatasourceImpl extends PhotoDatasource {

  final ApiService api;

  PhotoDatasourceImpl({required this.api});
  
  @override
  Future<bool> fetchNewCia(Map<String, dynamic> model) async {
    var response = await api.post(ApiConfig.createRestaurant, model);
    var settear = ResponseModel.fromJson(response);
    return true;
  }
  

}
import 'dart:io';
import 'package:prueba/core/api_config.dart';
import 'package:prueba/core/services/apiService.dart';
import 'package:prueba/data/model/response.model.dart';

abstract class PhotoDatasource {
  Future<bool> fetchNewCia(Map<String, dynamic> model); 
  Future<String> fetchUriPhoto(String name);
  Future<bool> fetchPhoto(String uri, File file);
}

class PhotoDatasourceImpl extends PhotoDatasource {

  final ApiService api;

  PhotoDatasourceImpl({required this.api});
  
  @override
  Future<bool> fetchNewCia(Map<String, dynamic> model) async {
    var response = await api.post(ApiConfig.createRestaurant, model);
     //await ResponseModel.fromJson(response);
    if (response != null) {
      var model = ResponseModel.fromJson(response);
      if (model != null) {
        print(model.data);
      }  
      return true;
    }
    else return false;
  }

  @override
  Future<String> fetchUriPhoto(String name) async {
    var response = await api.get('${ApiConfig.urlImage}${name}');
    if (response != null) return response['signedUrl'];
    else return ''; 
  }

  @override
  Future<bool> fetchPhoto(String uri, File file) async {
    var response = await api.put(uri, file);
    if(response) return true;
    else return false;
  }

}
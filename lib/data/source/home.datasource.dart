import 'dart:io';

import 'package:prueba/core/api_config.dart';
import 'package:prueba/core/services/apiService.dart';
import 'package:prueba/data/database/cia.dao.dart';
import 'package:prueba/data/database/photo.dao.dart';
import 'package:prueba/data/database/type_photo.dao.dart';
import 'package:prueba/data/model/cia.model.dart';
import 'package:prueba/data/model/photo.model.dart';
import 'package:prueba/data/model/response.model.dart';
import 'package:prueba/data/model/type_photo.model.dart';
import 'package:prueba/domain/entities/cia.dart';
import 'package:prueba/domain/entities/restaurant.dart';
import 'package:prueba/domain/entities/type_photo.dart';

abstract class HomeDatasource {
  Future<bool> fetchListType();
  Future<int> fetchTotPending();
  Future<List<Cia>> fetchTotRegister();
  Future<List<TypePhoto>> fetchTypeLocal();
  Future<Restaurant> fetchListPending();

  Future<bool> fetchNewCia(Map<String, dynamic> model);
  Future<String> fetchUriPhoto(String name);
  Future<bool> fetchPhoto(String uri, File file);

  Future<int> fetchPhotoUpdate(String _ruc);
}

class HomeDatasourceImpl implements HomeDatasource {
  final CiaDao dao;
  final TypePhotoDao type;
  final PhotoDao pdao;
  final ApiService api;

  HomeDatasourceImpl({
    required this.dao,
    required this.type,
    required this.pdao, 
    required this.api});
  
  @override
  Future<int> fetchTotPending() async {
    var list = await dao.getListOffOnline(); 
    return list.length;
  }

  @override
  Future<List<Cia>> fetchTotRegister() async {
    return await dao.getList(); 
  }
  
  @override
  Future<bool> fetchListType() async {
    try{
      final response = await api.get(ApiConfig.listPhoto);
      
      if(response != null) {
        var model = response['data'].map((json) => TypePhotoModel.fromJson(json));
        for( TypePhotoModel p in model) {
          await type.register(p.toJson());
        }
      }

      return true;
    } catch(xe) {
      //print(xe);
      throw Exception(xe);
      //return false;
    }
  }
  
  @override
  Future<List<TypePhoto>> fetchTypeLocal() async {
    return await type.getList();
  }

  @override
  Future<Restaurant> fetchListPending() async {
    List<CiaModel> ciaList =[];
    List<PhotoModel> photos = [];
    ciaList = await dao.getListOffOnline();
    photos = await pdao.getListOffOnline();
    
    return Restaurant(cias: ciaList, photos: photos);  
  }

  @override
  Future<bool> fetchNewCia(Map<String, dynamic> model) async {
    var response = await api.post(ApiConfig.createRestaurant, model);
    print('seteo');
    print(response);

    if (response != null) {
      var data = ResponseModel.fromJson(response);
      //if (data.data != null) {
        print('create');
        print(model);
        print(data);
        var _ruc = model['ruc'];
        await dao.updateEstado(_ruc);
      //}  
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
    print('ruta enviada :'+file.path);
    var response = await api.put(uri, file);
    return response;
  }

  @override
  Future<int> fetchPhotoUpdate(String _ruc) async {
    return await pdao.updateEstado(_ruc);
  }



}
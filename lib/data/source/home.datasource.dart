import 'package:prueba/core/api_config.dart';
import 'package:prueba/core/services/apiService.dart';
import 'package:prueba/data/database/cia.dao.dart';
import 'package:prueba/data/database/type_photo.dao.dart';
import 'package:prueba/data/model/type_photo.model.dart';
import 'package:prueba/domain/entities/type_photo.dart';

abstract class HomeDatasource {
  Future<bool> fetchListType();
  Future<int> fetchTotPending();
  Future<int> fetchTotRegister();
  Future<List<TypePhoto>> fetchTypeLocal();
}

class HomeDatasourceImpl implements HomeDatasource {
  final CiaDao dao;
  final TypePhotoDao type;
  final ApiService api;

  HomeDatasourceImpl({
    required this.dao,
    required this.type, 
    required this.api});
  
  @override
  Future<int> fetchTotPending() async {
    var list = await dao.getListOffOnline(); 
    return list.length;
  }

  @override
  Future<int> fetchTotRegister() async {
    var list = await dao.getList(); 
    return list.length;
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

}
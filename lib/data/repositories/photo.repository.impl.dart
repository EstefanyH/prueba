import 'dart:convert';

import 'package:prueba/core/util/app_constants.dart';
import 'package:prueba/data/database/cia.dao.dart';
import 'package:prueba/core/services/shared_preferences_service.dart';
import 'package:prueba/data/database/photo.dao.dart';
import 'package:prueba/data/model/cia.model.dart';
import 'package:prueba/data/model/photo.model.dart';
import 'package:prueba/data/source/photo.datasource.dart';
import 'package:prueba/domain/entities/cia.dart';
import 'package:prueba/domain/repository/photo.repository.dart';

class PhotoRepositoryImpl extends PhotoRepository{
  final PhotoDatasource datasource;
  final CiaDao dao;
  final PhotoDao pdao;
  final SharedPreferencesService shared;

  PhotoRepositoryImpl({
    required this.datasource,
    required this.dao,
    required this.pdao,
    required this.shared});
    
    @override
    Future<bool> postSaveData(bool isconnect) async {
      bool resultado = false;
      try {
        var data = shared.getString(AppConstant.p_cia);
        var toJson = jsonDecode(data ?? '');
        // guardando restaurant local
        await dao.register(toJson);
        
        if (isconnect) resultado = await datasource.fetchNewCia(toJson);

      }catch( xe ) {
        throw Exception(xe);
      }
      return resultado;
    }

  @override
  Future<Cia?> getCia()  async {
    try {
      var data = shared.getString(AppConstant.p_cia);
      if (data != null) {
        var toJson = jsonDecode(data ?? '');
        return CiaModel.fromJson(toJson);
      } else return null;
    }catch (xe){
      throw Exception(xe);
    }
  }

  @override
  Future<bool> postSavePhoto(PhotoModel model) async {
    try {
      bool resultado = false;
      var id =  await pdao.register(model);
      if(id > 0) resultado = true;
      return resultado;
      
    } catch(xe) {
      throw Exception(xe);
    }
  }

}
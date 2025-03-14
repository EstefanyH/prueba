import 'dart:convert';
import 'dart:io';

import 'package:prueba/core/util/app_constants.dart';
import 'package:prueba/data/database/cia.dao.dart';
import 'package:prueba/core/services/shared_preferences_service.dart';
import 'package:prueba/data/database/photo.dao.dart';
import 'package:prueba/data/database/type_photo.dao.dart';
import 'package:prueba/data/model/cia.model.dart';
import 'package:prueba/data/model/photo.model.dart';
import 'package:prueba/data/source/photo.datasource.dart';
import 'package:prueba/domain/entities/cia.dart';
import 'package:prueba/domain/entities/type_photo.dart';
import 'package:prueba/domain/repository/photo.repository.dart';

class PhotoRepositoryImpl extends PhotoRepository{
  final PhotoDatasource datasource;
  final CiaDao dao;
  final PhotoDao pdao;
  final TypePhotoDao tdao;
  final SharedPreferencesService shared;

  PhotoRepositoryImpl({
    required this.datasource,
    required this.dao,
    required this.pdao,
    required this.tdao,
    required this.shared});
    
    @override
    Future<bool> postSaveData(bool isconnect, List<PhotoModel> photos) async {
      bool resultado = false;
      try {
        var data = shared.getString(AppConstant.p_cia);
        var toJson = jsonDecode(data ?? '');
        // guardando restaurant local
        await dao.register(toJson);

        if(!photos.isEmpty) {
          for(PhotoModel photo in photos) {
            
            await postSavePhoto(photo);
          }
        }
        
        if (isconnect) {
          resultado = await datasource.fetchNewCia(toJson);
          //await dao.updateEstado(CiaModel.fromJson(toJson));

          bool presult = false;
          
          if(resultado) {
            for(PhotoModel photo in photos) {
              String uri = await datasource.fetchUriPhoto(photo.archivo);
              File _file = File(photo.ruta);
              print(photo.archivo);
              presult = await datasource.fetchPhoto(uri, _file);

              if(presult) await pdao.updateEstado(photo.archivo);
            }

            if (presult) {
              shared.removeValue(AppConstant.p_cia);
            }
          }
        }
        resultado = true;
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

  @override
  Future<List<TypePhoto>> getAllType() async {
    return await tdao.getList();
  }

  Future<String> getUriImage(String name) async {
    return await datasource.fetchUriPhoto(name);
  }

  Future<bool> putPhoto(String uri, String path ) async {
    File _file = File(path);
    return await datasource.fetchPhoto(uri, _file);
  }

}
import 'dart:io';

import 'package:prueba/data/source/home.datasource.dart';
import 'package:prueba/domain/entities/cia.dart';
import 'package:prueba/domain/entities/restaurant.dart';
import 'package:prueba/domain/entities/type_photo.dart';
import 'package:prueba/domain/repository/home.repository.dart';

class HomeRepositoryImpl  implements HomeRepository {
  final HomeDatasource datasource;

  HomeRepositoryImpl({required this.datasource});
  
  @override
  Future<int> getTotPending() async {
    return await datasource.fetchTotPending();
  }
  
  @override
  Future<List<Cia>> getTotRegister() async {
    return await datasource.fetchTotRegister();
  }
  
  @override
  Future<bool> getListType() async {
    return await datasource.fetchListType();
  }

  @override
  Future<List<TypePhoto>> getTypeLocal() async { 
    return datasource.fetchTypeLocal();
  }
  
  @override
  Future<bool> getRegisterPending() async {
    Restaurant  model = await datasource.fetchListPending();

    bool resultado = false;

    if(model == null){
      resultado = true;
    } else {
      for(var c in model.cias){
        await datasource.fetchNewCia(c.toJson());
      }

      for(var p in model.photos) {
        String _url = await datasource.fetchUriPhoto(p.archivo);
        File _file = File(p.ruta);
        if (_url!= '') {
          print(p.ruta);
          var result = await datasource.fetchPhoto(_url, _file);
          if(result ) await datasource.fetchPhotoUpdate(p.archivo);
        }
      }
      resultado = true;
    }
    
    return resultado;
  }
}
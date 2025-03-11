import 'dart:convert';

import 'package:prueba/core/util/app_constants.dart';
import 'package:prueba/data/model/cia.model.dart';
import 'package:prueba/core/services/shared_preferences_service.dart';
import 'package:prueba/data/source/new.datasource.dart';
import 'package:prueba/domain/repository/new.repository.dart';

class NewRepositoryImpl extends NewRepository {
  final NewDatasource datasource;
  final SharedPreferencesService shared;

  NewRepositoryImpl({
    required this.datasource,
    required this.shared});

  @override
  void getSave(CiaModel model) {
    var data = jsonEncode(model.toJson());
    shared.saveString(AppConstant.p_cia, data);
  }

}
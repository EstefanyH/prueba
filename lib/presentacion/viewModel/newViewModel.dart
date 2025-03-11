import 'package:flutter/material.dart';
import 'package:prueba/core/baseViewModel.dart';
import 'package:prueba/data/model/cia.model.dart';
import 'package:prueba/domain/enums/app_Enums.dart';
import 'package:prueba/domain/repository/new.repository.dart';

class NewViewModel extends BaseViewModel with ChangeNotifier {
  final NewRepository repository;
  
  NewViewModel({required this.repository});

  TextEditingController name_controller = TextEditingController();
  TextEditingController ruc_controller = TextEditingController();
  TextEditingController latitude_controller = TextEditingController();
  TextEditingController longitude_controller = TextEditingController();
  TextEditingController comment_controller = TextEditingController();

  var _name = '', _ruc = '', _latitud = '', _longitud = '', _comment = '';
   
  Future<void> init() async {
    clear();
  }

  void clear() {
    name_controller.text = '';
    ruc_controller.text = '';
    latitude_controller.text = '';
    longitude_controller.text = '';
    comment_controller.text = '';
  }

  void onSaved(CiaType type, String value) {
    
    switch(type) {
      case CiaType.name : _name = value; break;
      case CiaType.ruc: _ruc = value; break;
      case CiaType.latitud: _latitud = value; break;
      case CiaType.longitud: _longitud = value; break;
      case CiaType.comment: _comment = value; break;
    }

    var model = CiaModel(
      name: _name, 
      ruc: _ruc, 
      latitude: _latitud, 
      longitude: _longitud, 
      comment: _comment);

    repository.getSave(model);
  }

}
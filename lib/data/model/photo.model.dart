import 'package:prueba/domain/entities/photo.dart';

class PhotoModel extends Photo{

  PhotoModel({required super.ruc, required super.archivo, required super.tipo, required super.ruta});

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      ruc: json['ruc'], 
      archivo: json['archivo'], 
      tipo: json['tipo'],
      ruta: json['ruta']);
  }

  Map<String, dynamic> toJson() {
    return {
      'ruc': ruc,
      'archivo': archivo,
      'tipo': tipo,
      'ruta': ruta,
      'enviado':'0'
    };
  }
}
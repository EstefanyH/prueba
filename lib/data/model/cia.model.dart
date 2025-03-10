import 'package:prueba/domain/entities/cia.dart';

class CiaModel extends Cia {

  CiaModel({
    required super.name, 
    required super.ruc, 
    required super.latitude,
    required super.longitude,
    required super.comment});
  
  factory CiaModel.fromJson(Map<String, dynamic> json) {
    return CiaModel(
      name: json['name'], 
      ruc: json['ruc'], 
      latitude: json['latitude'], 
      longitude: json['longitude'], 
      comment: json['comment']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'ruc': ruc,
      'latitude': latitude,
      'longitude': longitude,
      'comment': comment,
      'enviado':'0'
    };
  }
}
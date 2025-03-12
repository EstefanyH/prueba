import 'package:prueba/domain/entities/position.dart';

class PositionsModel extends Positions {

  PositionsModel({required super.latitude, required super.longitude});
  
  factory PositionsModel.fromJson(Map<String, dynamic> json) {
    return PositionsModel(
      latitude: json['latitude'], 
      longitude: json['longitude']);
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude
    };
  }

}


import 'package:prueba/domain/entities/response.dart';

class ResponseModel extends Response{
  
  ResponseModel({required super.message, required super.data});
   
 
  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    var _json = json['data'] as List;

    return ResponseModel(
      message: json['message'], 
      data: json['data']);
  }
}
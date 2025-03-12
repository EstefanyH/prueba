

import 'package:prueba/domain/entities/response.dart';

class ResponseModel extends Response{
  
  ResponseModel({required super.message, required super.data});
   
 
  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return ResponseModel(
      message: json['message'] ?? json['mensaje'], 
      data: json['data'] ?? null );
  }
}
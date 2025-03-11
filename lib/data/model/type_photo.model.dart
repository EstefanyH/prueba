import 'package:prueba/domain/entities/type_photo.dart';

class TypePhotoModel extends TypePhoto{

  TypePhotoModel({
    required super.uuid, 
    required super.name, required super.description});

  factory TypePhotoModel.fromJson(Map<String, dynamic> json) {
    return TypePhotoModel(
      uuid: json['uuid'], 
      name: json['name'], 
      description: json['description']);
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name,
      'description': description
    };
  }
}
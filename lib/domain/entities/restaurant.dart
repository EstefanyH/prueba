import 'package:prueba/data/model/cia.model.dart';
import 'package:prueba/data/model/photo.model.dart';

class Restaurant {
  final List<CiaModel> cias;
  final List<PhotoModel> photos;
  Restaurant({required this.cias, required this.photos});
}
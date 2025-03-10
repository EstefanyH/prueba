
import 'package:prueba/data/source/restaurant.datasource.dart';
import 'package:prueba/domain/repository/restaurant.repository.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantDatasource datasource;

  RestaurantRepositoryImpl({required this.datasource});
}
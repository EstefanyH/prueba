import 'package:prueba/data/database/cia.dao.dart';

abstract class RestaurantDatasource {
  Future<int> fetchRegister();
}

class RestaurantDatasourceImpl implements RestaurantDatasource {
  final CiaDao dao;

  RestaurantDatasourceImpl({ required this.dao});
  
  @override
  Future<int> fetchRegister() async {
    // TODO: implement fetchRegister
    throw UnimplementedError();
  }

}
import 'package:prueba/data/database/cia.dao.dart';

abstract class HomeDatasource {
  Future<int> fetchTotPending();
  Future<int> fetchTotRegister();
}

class HomeDatasourceImpl implements HomeDatasource {
  final CiaDao dao;

  HomeDatasourceImpl({required this.dao});
  
  @override
  Future<int> fetchTotPending() async {
    var list = await dao.getListOffOnline(); 
    return list.length;
  }

  @override
  Future<int> fetchTotRegister() async {
    var list = await dao.getList(); 
    return list.length;
  }

}
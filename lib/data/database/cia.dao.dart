
import 'package:prueba/data/database/databaseHelper.dart';
import 'package:prueba/data/model/cia.model.dart';

class CiaDao {
  final DatabaseHelper _dbHelper;
  late String tbName = DatabaseHelper.tbEmpresa;

  CiaDao(this._dbHelper);

  Future<int> register(CiaModel model) async{
    final db = await _dbHelper.database;
    return await db.insert(tbName, model.toJson());
  }

  Future<List<CiaModel>> getListOffOnline() async {
    final db = await _dbHelper.database;
    List<Map<String, dynamic>> maps = await db.query(tbName,
    where: '${DatabaseHelper.colisEnviado} == ?',
    whereArgs: [0] );
    return maps.map((map) => CiaModel.fromJson(map)).toList();
  }

}
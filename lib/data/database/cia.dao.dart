
import 'package:prueba/data/database/databaseHelper.dart';
import 'package:prueba/data/model/cia.model.dart';

class CiaDao {
  final DatabaseHelper _dbHelper;
  late String tbName = DatabaseHelper.tbEmpresa;

  CiaDao(this._dbHelper);

  Future<int> register(var model) async{
    try {
    final db = await _dbHelper.database;
    return await db.insert(tbName, model);
    } catch(xe ){
      throw Exception(xe);
    }
  }

  Future<List<CiaModel>> getListOffOnline() async {
    final db = await _dbHelper.database;
    List<Map<String, dynamic>> maps = await db.query(tbName,
    where: '${DatabaseHelper.colEnviado} == ?',
    whereArgs: [0] );
    return maps.map((map) => CiaModel.fromJson(map)).toList();
  }

  Future<List<CiaModel>> getList() async {
    final db = await _dbHelper.database;
    List<Map<String, dynamic>> maps = await db.query(tbName);
    return maps.map((map) => CiaModel.fromJson(map)).toList();
  }

  Future<int> updateEstado(String ruc) async {
    final db = await _dbHelper.database;
    Map<String, dynamic> row = {
      DatabaseHelper.colEnviado : 1
    };

    return await db.update(
      tbName,
      row,
      where: 'ruc = ?',
      whereArgs: [ruc],
    );
  }


}
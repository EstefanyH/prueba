
import 'package:prueba/data/database/databaseHelper.dart';
import 'package:prueba/data/model/photo.model.dart';

class PhotoDao {
final DatabaseHelper _dbHelper;
  late String tbName = DatabaseHelper.tbFotos;

  PhotoDao(this._dbHelper);
  
  Future<int> register(PhotoModel model) async{
    try {
      final db = await _dbHelper.database;
      print(model.toJson());
      return await db.insert(tbName, model.toJson());
    } catch(xe) {
      throw Exception(xe);
    }
  }

  Future<List<PhotoModel>> getListOffOnline() async {
    final db = await _dbHelper.database;
    List<Map<String, dynamic>> maps = await db.query(tbName,
    where: '${DatabaseHelper.colEnviado} == ?',
    whereArgs: [0] );
    return maps.map((map) => PhotoModel.fromJson(map)).toList();
  }

  Future<int> updateEstado(PhotoModel model) async {
    final db = await _dbHelper.database;
    Map<String, dynamic> row = {
      DatabaseHelper.colEnviado : 1
    };

    return await db.update(
      tbName,
      row,
      where: 'ruc = ?',
      whereArgs: [model.ruc],
    );
  }

}
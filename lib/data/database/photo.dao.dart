
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

}
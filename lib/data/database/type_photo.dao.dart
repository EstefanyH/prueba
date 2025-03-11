
import 'package:prueba/data/database/databaseHelper.dart';
import 'package:prueba/data/model/type_photo.model.dart';

class TypePhotoDao {
final DatabaseHelper _dbHelper;
  late String tbName = DatabaseHelper.tbTipo;


  TypePhotoDao(this._dbHelper);
  
  Future<int> register(var model) async{
    final db = await _dbHelper.database;
    return await db.insert(tbName, model);
  }

  Future<List<TypePhotoModel>> getList() async {
    final db = await _dbHelper.database;
    List<Map<String, dynamic>> maps = await db.query(tbName);
    return maps.map((map) => TypePhotoModel.fromJson(map)).toList();
  }

}
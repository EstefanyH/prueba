import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DatabaseHelper {
    static const String _dbName = 'prueba.db';
    static const int _dbVersion = 1;

    static const String tbEmpresa = 'empresa';
    static const String tbFotos = 'foto';
    static const String tbTipo = 'tipo';
//name, ruc, latitude, longitude, comment, enviado
    static const String colId = 'id';
    static const String colNombre = 'name';
    static const String colRuc = 'ruc';
    static const String colLatitud = 'latitude';
    static const String colLongitud = 'longitude';
    static const String colComentario = 'comment';
    static const String colisEnviado = 'enviado'; // 1: online, 0: offline

    static const String colruta = 'ruta';
    static const String colarchivo = 'archivo';

    static const String coluuid = 'uuid';
    static const String colname = 'name';
    static const String coldescription = 'description';

    static final DatabaseHelper _instance = DatabaseHelper._internal();
    factory DatabaseHelper() => _instance;
    DatabaseHelper._internal();

    static Database? _database;

    Future<Database> get database async {
        if(_database != null) return _database!;
        _database = await _initDatabase();
        return _database!;
    }

    Future<Database> _initDatabase() async {
        final dbPath = await getDatabasesPath();
        final path = join(dbPath, _dbName);

        return await openDatabase(
            path,
            version: _dbVersion,
            onCreate: _onCreate);
    }

    Future<void> _onCreate(Database db, int version) async {
        await db.execute('''
            CREATE TABLE $tbEmpresa (
            $colId INTEGER PRIMARY KEY AUTOINCREMENT,
            $colNombre TEXT NOT NULL,
            $colRuc TEXT NOT NULL,
            $colLatitud TEXT NOT NULL,
            $colLongitud TEXT NOT NULL,
            $colComentario TEXT NOT NULL,
            $colisEnviado INTEGER
            );
        ''');

        await db.execute('''
            CREATE TABLE $tbFotos (
            $colId INTEGER PRIMARY KEY AUTOINCREMENT,
            $colRuc INTEGER,
            $colarchivo TEXT NOT NULL,
            $colruta TEXT NOT NULL,
            $colisEnviado INTEGER
            );
        ''');

        await db.execute('''
            CREATE TABLE $tbTipo (
            $coluuid TEXT PRIMARY KEY ,
            $colname TEXT NOT NULL,
            $coldescription TEXT NOT NULL
            );
        ''');
    }

    Future<void> close() async {
        final db = await database;
        db.close();
    }
}
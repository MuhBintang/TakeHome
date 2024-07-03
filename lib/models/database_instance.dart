import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:takehome/models/model_all.dart';

class DatabaseInstance {
  final String _databaseName = 'ricknmorty.db';
  final int _databaseVersion = 7;

  final String table = 'favourite';
  final String id = 'id';
  final String name = 'name';
  final String image = 'image';
  final String location = 'location';
  final String species = 'species';
  final String gender = 'gender';
  final String origin = 'origin';
  final String status = 'status';
  final String type = 'type';

  Database? _database;

  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);
    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $table ($id INTEGER PRIMARY KEY, $name TEXT, $image TEXT, $location TEXT, $species TEXT, $gender TEXT, $origin TEXT, $status TEXT)'
    );
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    
  }

  Future<void> insertFavourite(Result character) async {
    final db = await database();
    await db.insert(
      table,
      {
        'id': character.id,
        'name': character.name,
        'image': character.image,
        'location': character.location.name,
        'species': character.species,
        'gender': character.gender,
        'origin': character.origin.name,
        'status': character.status,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Result>> getFavouriteCharacters() async {
    final db = await database();
    final List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) {
      return Result(
        id: maps[i]['id'],
        name: maps[i]['name'],
        image: maps[i]['image'],
        location: Location(name: maps[i]['location'], url: 'https://rickandmortyapi.com/api/character'),
        species: maps[i]['species'],
        gender: maps[i]['gender'],
        origin: Location(name: maps[i]['origin'], url: 'https://rickandmortyapi.com/api/character'),
        status: maps[i]['status'],
      );
    });
  }

  Future<void> deleteFavourite(int id) async {
    final db = await database();
    int rowsAffected = await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );

    print('Rows affected: $rowsAffected');
  }
}

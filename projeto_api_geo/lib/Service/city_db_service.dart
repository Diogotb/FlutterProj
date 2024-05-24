import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/city_model.dart';

class CityDataBaseService {
  static const String DB_NOME = 'cities.db'; // Nome do banco de dados
  static const String TABLE_NOME = 'cities'; // Nome da tabela
  static const String CREATE_CONTACTS_TABLE_SCRIPT = // Script SQL para criar a tabela
      """CREATE TABLE cities(
        id SERIAL, 
        cityname TEXT, 
        favoritecities BOOLEAN DEFAULT false)""";

  Future<Database> _getDatabase() async{
    return openDatabase(
      join(await getDatabasesPath(), DB_NOME), // Caminho do banco de dados
      onCreate: (db, version) {
        return db.execute(
            CREATE_CONTACTS_TABLE_SCRIPT); // Executa o script de criação da tabela quando o banco é criado
      },
      version: 1,
    );
  }
  //list all cities
  Future<List<City>> getAllCities() async {
    Database db = await _getDatabase();
    List<Map<String, dynamic>> maps = await db.query(TABLE_NOME);
    return  List.generate(
        maps.length,
        (i) {
          return City.fromMap(maps[i]);
        },
      );
  }
  //insert a new city
  Future<int> insertCity(City city) async {
    Database db = await _getDatabase();
    return await db.insert(TABLE_NOME, city.toMap());
  }
  
  //update favoriteCities
  Future<int> updateCity(City city) async {
    Database db = await _getDatabase();
    return await db.update(TABLE_NOME, city.toMap(), where: 'cityname =?', whereArgs: [city.cityName]);
  }
}
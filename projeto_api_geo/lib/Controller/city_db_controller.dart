import 'package:projeto_api_geo/Service/city_db_service.dart';

import '../Model/city_model.dart';

class CityDBController {
  final CityDataBaseService _service = CityDataBaseService();
  List<City> _cityList = [];
  
  //get
  List<City> get cityList => _cityList;
  
  // métodos
  Future<List<City>> getAllCities() async {
    try {
      List<Map<String, dynamic>> cities = await _service.getAllCities();
      _cityList = cities.map<City>((e) => City.fromMap(e)).toList();
      return cityList;
    } catch (e) {
      print(e);
      _cityList=[];
      return cityList;
    }
  }
  Future<void> insertCity(City city) async {
    try {
      await _service.insertCity(city);
    } catch (e) {
      print(e);
    }
  }
}

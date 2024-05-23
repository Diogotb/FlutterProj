import 'package:projeto_api_geo/Services/weather_service.dart';

import '../Model/weather_model.dart';

class WeatherController {
  final WeatherService _service = WeatherService();
  final List<Weather> _weatherList = [];
  
  //get
  List<Weather> get weatherList => _weatherList;

  // métodos
  //latitude e longitude
  Future<void> getWeatherbyLocation(double lat, double lon) async{
    try {
      Weather weather = Weather.fromJson(
        await _service.getWeatherByLocation(lat, lon)
      );
      weatherList.add(weather);
    } catch (e) {
      print(e);
    }
  }

  // cidade
  Future<bool> findCity(String city) async{
    try{
      Weather weather = Weather.fromJson(await _service.getWeatherbyCity(city));
      weatherList.add(weather);
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }
  
}
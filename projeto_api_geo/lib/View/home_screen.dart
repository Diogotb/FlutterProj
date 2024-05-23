import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:projeto_api_geo/Controller/weather_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherController _controller = WeatherController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _getWeather() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      _controller.getWeatherbyLocation(position.latitude, position.longitude);
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projeto API Geo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/search');
                    },
                    child: const Text("Search")),
                ElevatedButton(onPressed: () {}, child: const Text("Favoritos"))
              ],
            ),
            const SizedBox(height: 20),
            FutureBuilder(
                future: _getWeather(),
                builder: (context, snapshot) {
                  if (_controller.weatherList.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Column(
                      children: [
                        Text(_controller.weatherList.last.name),
                        const SizedBox(height: 10),
                        Text(_controller.weatherList.last.description),
                        const SizedBox(height: 10),
                        Text((_controller.weatherList.last.temp - 273)
                            .toStringAsFixed(2)),
                        IconButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: () {
                            _getWeather();
                          },
                        )
                      ],
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}

class Weather {
  //atributos
  final String name;
  final String description;
  final double temp;
  // construtor
  Weather({required this.name, required this.description, required this.temp});
  // fromApi
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      name: json['name'],
      description: json['weather'][0]['description'],
      temp: json['main']['temp'],
    );
  }
  
  

}
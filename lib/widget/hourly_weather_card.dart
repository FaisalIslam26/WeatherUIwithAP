import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HourlyWeatherCard extends StatefulWidget {
  const HourlyWeatherCard({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  State<HourlyWeatherCard> createState() => _HourlyWeatherCardState();
}

class _HourlyWeatherCardState extends State<HourlyWeatherCard> {
  final String baseUrl = "https://api.openweathermap.org/";
  final String apiKey = "f93e1a3255ce8fcd8e0a0090643d493c";
  final String lat = "23.777176";
  final String lon = "90.399452";
  final String units = "metric";

  final String api = "data/2.5/onecall?";

  Map weatherData = {};
  Future getWeather() async {
    final response = await http.get(Uri.parse(baseUrl +
        api +
        "lat=$lat" +
        "&" +
        "lon=$lon" +
        "&units=$units" +
        "&exclude=minutely" +
        "&appid=$apiKey"));
    if (response.statusCode == 200) {
      setState(() {
        weatherData = jsonDecode(response.body);
      });
    }
  }

  @override
  void initState() {
    getWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      height: 132,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0xff4B3EAE),
          Color(0xff766CC1),
          Color(0xff4B3EAE),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            "${weatherData["hourly"][0]["dt"]}",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          Image.asset("assets/Cloud3.png"),
          Text(
            "${weatherData["hourly"][0]["temp"]}",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/screen/details.dart';
import 'package:weatherapp/widget/column_builder.dart';
import 'package:weatherapp/widget/hourly_weather_card.dart';
import 'package:weatherapp/widget/weather_card.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  static const String path = "HomeScreen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String baseUrl = "https://api.openweathermap.org/";
  final String apiKey = "f93e1a3255ce8fcd8e0a0090643d493c";
  final String lat = "23.777176";
  final String lon = "90.399452";

  final String api = "data/2.5/onecall?";

  Map weatherData = {};
  Future getWeather() async {
    final response = await http.get(Uri.parse(baseUrl +
        api +
        "lat=$lat" +
        "&" +
        "lon=$lon" +
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

  int convertTemp(temp) {
    int result = (temp - 273).toInt();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF1F0FA),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "${weatherData["timezone"]}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("${weatherData["timezone_offset"]}"),
              SizedBox(
                height: 8,
              ),
              CarouselSlider(
                options: CarouselOptions(height: 400),
                items: [1, 2, 3, 4, 5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return WeatherCard(
                        temp: "${convertTemp(weatherData["current"]["temp"])}",
                        weather:
                            "${weatherData["current"]["weather"][0]["description"]}",
                        onTap: () {
                          Navigator.pushNamed(context, DetailsScreen.path);
                        },
                      );
                    },
                  );
                }).toList(),
              ),
              Container(
                // color: Color(0xff766CC1).withOpacity(0.35),
                margin: EdgeInsets.only(top: 80),
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ColumnBuilder(
                      imageName: "carbon_humidity",
                      value: weatherData["current"]["humidity"].toString(),
                      level: "Humidity",
                    ),
                    ColumnBuilder(
                      imageName: "Group",
                      value: "${weatherData["current"]["wind_speed"]} km/h",
                      level: "wind",
                    ),
                    ColumnBuilder(
                      imageName: "airpre1",
                      value: "${weatherData["current"]["pressure"]}",
                      level: "Air Pressure",
                    ),
                    ColumnBuilder(
                      imageName: "ic_round-visibility",
                      value:
                          "${weatherData["current"]["visibility"] / 1000} km",
                      level: "Visibility",
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Today",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Next 7 Days",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, DetailsScreen.path);
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 140,
                margin: EdgeInsets.only(top: 32),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: HourlyWeatherCard(),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

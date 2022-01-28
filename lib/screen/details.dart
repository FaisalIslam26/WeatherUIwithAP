import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weatherapp/screen/home.dart';
import 'package:weatherapp/widget/dailyweather.dart';
import 'package:http/http.dart' as http;

class DetailsScreen extends StatefulWidget {
  final String? daily;
  final String? dt;
  final String? temp;
  static const String path = "DetailsScreen";
  const DetailsScreen({
    Key? key,
    this.daily,
    this.dt,
    this.temp,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
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
        "&exclude=minutely,hourly" +
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
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff4B3EAE),
              Color(0xff766CC1),
              Color(0xff4B3EAE),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Column(
                    children: [
                      Text(
                        "Today's Weather",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Sunday 8th March 2021",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xff766CC1),
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                  width: 2,
                  color: Colors.white,
                ),
              ),
              child: Row(
                children: [
                  Image.asset("assets/Moon_Cloud.png"),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "23°",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 72,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Moon Cloud Fast Wind",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueGrey.withOpacity(0.30),
                            offset: Offset(0, -40),
                            spreadRadius: -10,
                          )
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 80),
                            child: Text(
                              "Future Weather",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: 7,
                                itemBuilder: (context, index) {
                                  return DailyWeatherListBuilder(
                                    hasDivider: index < 6 ? true : false,
                                    imageName: "Sun cloud angled rain",
                                    temp:
                                        "${weatherData["daily"][0]["temp"]["day"]}",
                                    day: "Monday",
                                    date: "10 March 2021",
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

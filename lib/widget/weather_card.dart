import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final VoidCallback? onTap;
  final String? dateTime;
  final String? temp;
  final String? weather;
  final String? timezone;
  final String? dt;
  const WeatherCard({
    Key? key,
    this.onTap,
    this.dateTime,
    this.temp,
    this.weather,
    this.timezone,
    this.dt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 238,
            height: 392,
          ),
          Positioned(
            top: 30,
            child: Container(
              width: 238,
              height: 330,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xff4B3EAE),
                  Color(0xff766CC1),
                  Color(0xff4B3EAE),
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(40),
                shape: BoxShape.rectangle,
              ),
              child: Column(
                children: [
                  Text("weather"),
                  Image.asset(
                    "assets/Moon_Cloud.png",
                    scale: 1.5,
                  ),
                  // Text(
                  //   "24°",
                  //   style: TextStyle(
                  //     fontSize: 72,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.white,
                  //   ),
                  // ),
                  // Text(
                  //   "Moon Cloud Fast Wind",
                  //   style: TextStyle(
                  //     fontSize: 12,
                  //     fontWeight: FontWeight.w500,
                  //     color: Colors.white,
                  //   ),
                  // )

                  Text(
                    "$temp",
                    style: TextStyle(
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "$weather",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 15,
            child: Container(
              height: 34,
              width: 140,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Center(
                //   child: Text(
                //     "Sunday, 8 March 2021",
                //     style: TextStyle(
                //       fontSize: 12,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.black,
                //     ),
                //   ),
                // ),
                child: Text(
                  "$dateTime",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

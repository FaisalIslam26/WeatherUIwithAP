import 'package:flutter/material.dart';

class ColumnBuilder extends StatelessWidget {
  final String? imageName;
  final String? value;
  final String? level;
  const ColumnBuilder({Key? key, this.imageName, this.level, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("assets/$imageName.png"),
        Text(
          "$value",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          "$level",
          style: TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

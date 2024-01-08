import "package:flutter/material.dart";

class HourlyWeather extends StatelessWidget {
  final IconData icon;
  final String text;
  final String value;
  const HourlyWeather(
      {super.key, required this.icon, required this.value, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 35,
        ),
        Text(text),
        Text(value)
      ],
    );
  }
}

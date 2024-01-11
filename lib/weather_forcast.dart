import 'package:flutter/material.dart';

class WeatherForcast extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temperature;
  const WeatherForcast(
      {super.key,
      required this.time,
      required this.icon,
      required this.temperature});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Card(
          elevation: 10,
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Text(
                time,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Icon(icon),
              const SizedBox(
                height: 12,
              ),
              Text(temperature),
              const SizedBox(
                height: 12,
              )
            ],
          )),
    );
  }
}

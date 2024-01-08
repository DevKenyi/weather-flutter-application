import 'package:flutter/material.dart';
import 'package:weather_app/weather_app.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const WeatherApp(),
        theme: ThemeData.dark(useMaterial3: true)
        // .copyWith(appBarTheme: AppBarTheme()),
        );
  }
}

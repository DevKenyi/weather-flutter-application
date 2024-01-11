import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/HourlyWeather%20.dart';
import 'package:weather_app/TimeCal.dart';
import 'package:weather_app/secretKey.dart';
import 'package:weather_app/weather_forcast.dart';
import 'package:http/http.dart' as http;

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  // @override
  // void initState() {
  //   super.initState();
  //   getWeatherData();
  // }

  Future<Map<String, dynamic>> getWeatherData() async {
    const String cityName = "Nigeria";
    const String baseUrl = "http://api.openweathermap.org";
    const String path = "/data/2.5/forecast?q=$cityName,&APPID=$openApiKey";

    try {
      final response = await http.get(Uri.parse("$baseUrl/$path"));
      final data = jsonDecode(response.body);
      if (data['cod'] != '200') {
        print("data here  for deb $data");

        throw Exception("Unexpected error occured");
      }
      return data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                getWeatherData();
              },
              icon: const Icon(Icons.refresh))
        ],
        title: const Text("Weather App",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getWeatherData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.none) {
            const Text("Some error occured!");
          }

          final data = snapshot.data!;
          //print("find check data here  $data");

          final currentTempDataInKelvin = data["list"][0]["main"]["temp"];
          final tempInCensius = currentTempDataInKelvin - 273.15;

          final humidiy = data["list"][0]["main"]["humidity"].toString();

          final pressure = data["list"][0]["main"]["pressure"].toString();

          final windSpeed = data["list"][0]["wind"]["speed"];
          print("wind speed here $windSpeed");

          //geting the data for weather e.g raining, cloudy or sunny

          final weatherType = data["list"][0]["weather"][0]["main"];
          print("Weather type $weatherType");

          //iterating to get values such as time and temperatures at varying times

          Map<String, dynamic> mappedData = data;

          List<dynamic> listData = mappedData["list"];
          List<Widget> weatherCards = [];

          for (var item in listData) {
            //converting to readable time date object
            int timeData = item["dt"];
            double temp = item["main"]["temp"] - 273.15;

            String currentTemp = temp.toStringAsFixed(1);

            var timeCal = TimeCalculation();
            var tm = timeCal.convertMillisecondsToDateTime(timeData.toDouble());
            WeatherForcast weatherForcast = WeatherForcast(
                time: tm,
                icon: Icons.cloud_circle_rounded,
                temperature: "$currentTemp°C");

            weatherCards.add(weatherForcast);
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          elevation: 10,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "${tempInCensius.toStringAsFixed(1)}°C",
                                      style: const TextStyle(
                                          fontSize: 36,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Icon(
                                      (weatherType == "Clouds" ||
                                              weatherType == "Rain"
                                          ? Icons.cloud_circle_rounded
                                          : Icons.sunny),
                                      size: 70,
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      weatherType,
                                      style: const TextStyle(fontSize: 30),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Weather Forecast",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: weatherCards,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  "Additional Information",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    HourlyWeather(
                      icon: Icons.water_drop_rounded,
                      text: "Humitity",
                      value: humidiy,
                    ),
                    HourlyWeather(
                        icon: Icons.air_outlined,
                        text: "Wind Speed",
                        value: windSpeed.toString()),
                    HourlyWeather(
                      icon: Icons.beach_access_outlined,
                      text: "Pressure",
                      value: pressure,
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

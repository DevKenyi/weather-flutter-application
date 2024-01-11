import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TestApi extends StatefulWidget {
  const TestApi({super.key});

  @override
  State<TestApi> createState() => _TestApiState();
}

class _TestApiState extends State<TestApi> {
  Future getTempApi() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/todos/1"));
    final data = jsonDecode(response.body);
    if (data == "200") {
      return data;
    }
    return "Error occured ";
  }

  @override
  Widget build(BuildContext context) {
    final responseData = getTempApi();
    print(responseData);
    return const MaterialApp(
      home: Scaffold(
        body: Text("data"),
      ),
    );
  }
}

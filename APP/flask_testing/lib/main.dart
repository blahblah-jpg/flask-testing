import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter to Flask')),
        body: Center(
          child: ElevatedButton(
            onPressed: sendArray,
            child: Text('Send Array'),
          ),
        ),
      ),
    );
  }

  void sendArray() async {
    List<List<List<double>>> array = List.generate(
      1,
      (_) => List.generate(
        33,
        (_) => List.generate(
          847,
          (_) => Random().nextDouble(),
        ),
      ),
    );

    var url = Uri.parse('http://127.0.0.1:5000/endpoint');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(array),
    );

    if (response.statusCode == 200) {
      var output = jsonDecode(response.body);
      print('Model output: $output');
    } else {
      print('Failed to get model output');
    }
  }
}
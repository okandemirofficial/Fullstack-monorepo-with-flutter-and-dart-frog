import 'package:common_models/common_models.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> carBrands = [];

  void _getCars() async {
    try {
      final res = await Dio().get('http://10.0.2.2:8080/car');

      for (var e in res.data['cars']) {
        carBrands.add(Car.fromJson(e).brand);
      }
    } catch (e) {
      throw Exception(e);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Cars'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: carBrands
              .map((e) => Text(
                    e,
                    style: Theme.of(context).textTheme.titleLarge,
                  ))
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getCars,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

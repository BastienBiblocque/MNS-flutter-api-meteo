import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meteo/service/openWeatherService.dart';

import '../service/apiNinjaService.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? weather;

  void searchWeather() {
    setState(() {
      getCityInformation().then((value) => {
            getWeatherData(value).then((value) => {
                  weather = value['main']['temp'].toString(),
                }),
          });
    });
  }

  getCityInformation() async {
    final response = await ApiNinjaService().getCityInformation("Metz");
    return response;
  }

  getWeatherData(value) async {
    final response = await OpenWeatherService()
        .getWeatherData(value[0]['latitude'], value[0]['longitude']);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    print(weather);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              weather != null ? 'Il fait $weather degrès à Metz !' : '',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: searchWeather,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'dart:convert';
import 'package:clima_flutter/screens/location_screen.dart';
import 'package:clima_flutter/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:clima_flutter/services/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima_flutter/services/weather.dart';

const apiKey = 'ced50569df56fe817bec5ed106175963';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String? errorMessage;

  void getLocationData() async {
    try {
      var weatherData = await WeatherModel().getLocationWeather();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return LocationScreen(
            locationWeather: weatherData,
          );
        }),
      );
    } catch (error) {
      setState(() {
        errorMessage = '$error';
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getLocationData();
    return Scaffold(
      body: Center(
        child: errorMessage != null
            ? Text('$errorMessage')
            : SpinKitDoubleBounce(
                color: Colors.white,
                size: 100.0,
              ),
      ),
    );
  }
}

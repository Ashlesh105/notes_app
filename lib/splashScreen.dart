import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'main.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const EngiNotesHub()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarBrightness: Brightness.light),
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Colors.deepPurple,Colors.blueAccent])
        ),
        child: Center(
          child: Column(
            children: [
              Lottie.asset('assets/splash.json'),
              const Text(
                'EngiNotesHub',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black, fontFamily: 'Agbalumo', fontSize: 25),
              )
            ],
          ),
        ),
      ),
    );
  }
}

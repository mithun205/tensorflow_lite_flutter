
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tensorflow_lite_flutter/screens/detect_screen.dart';
import 'package:tensorflow_lite_flutter/screens/hompege%20.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sign shot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const homepage(),

      routes: {
         "/detect scrn_page" :(context) =>  const DetectScreen(),   
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:moviedb/homepage.dart';
import 'package:moviedb/pages/mainpage.dart';

import 'LoginScreen.dart';
void main()
{
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:"Movie",
      debugShowCheckedModeBanner: false,
      home: loginScreen(),
    );
  }
}



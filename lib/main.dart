import 'package:flutter/material.dart';

import './pages/home_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.lightGreen,
        splashColor: Colors.lightGreen,
      ),
      home:HomePage(),
    );
  }
}
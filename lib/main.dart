import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Pages
import 'package:deezer_app/pages/login/login_page.dart';
import 'package:deezer_app/pages/home/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // statusBarColor: Colors.transparent,
    // ));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Sans'),
        title: 'Dezzer App',
        home: LoginPage());
  }
}

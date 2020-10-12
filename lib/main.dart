import 'package:deezer_app/pages/splash/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// Pages
import 'package:deezer_app/pages/login/login_page.dart';
import 'package:deezer_app/pages/home/home_page.dart';

import 'db/db.dart';

void main() async {
  // await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await DB.instance.init();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (_, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Firebase erroe"),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Sans'),
            title: 'Dezzer App',
            home: SplashPage(),
            routes: {
              SplashPage.routeName: (_) => SplashPage(),
              HomePage.routeName: (_) => HomePage(),
              LoginPage.routeName: (_) => LoginPage()
            },
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

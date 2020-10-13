import 'dart:io';

import 'package:deezer_app/db/app_theme.dart';
import 'package:deezer_app/pages/splash/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Pages
import 'package:deezer_app/pages/login/login_page.dart';
import 'package:deezer_app/pages/home/home_page.dart';
import 'package:provider/provider.dart';

import 'db/db.dart';

void main() async {
  // await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await DB.instance.init();
  await MyAppTheme.instance.init();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: MyAppTheme.instance,
        child: Consumer<MyAppTheme>(
          builder: (_, __, ___) {
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
                    theme: MyAppTheme.instance.theme,
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
                  child: (Platform.isIOS)
                      ? CupertinoActivityIndicator()
                      : CircularProgressIndicator(),
                );
              },
            );
          },
        ));
  }
}

import 'package:deezer_app/db/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';

class MyAppTheme extends ChangeNotifier {
  MyAppTheme._internal();
  static MyAppTheme _instance = MyAppTheme._internal();
  static MyAppTheme get instance => _instance;

  final StoreRef _store = StoreRef.main();
  final Database _db = DB.instance.database;

  bool _darkEnabled;
  bool get darkEnabled => _darkEnabled;

  ThemeData get theme {
    if (_darkEnabled) {
      return ThemeData(
          scaffoldBackgroundColor: Color(0xff102027),
          fontFamily: "Sans",
          brightness: Brightness.dark);
    }
    return ThemeData(fontFamily: "Sans");
  }

  Future<void> init() async {
    this._darkEnabled =
        (await this._store.record('darkEnabled').get(_db)) as bool ?? false;
  }

  Future<void> setTheme(bool isDarkEnabled) async {
    await this._store.record('darkEnabled').put(_db, isDarkEnabled);
    this._darkEnabled = isDarkEnabled;
    notifyListeners();
  }
}

import 'package:deezer_app/libs/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Widgets
import 'widgets/home_header.dart';

class HomePage extends StatefulWidget {
  static final routeName = 'home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          HomeHeader(),
          SliverToBoxAdapter(
            child: Container(
              child: FlatButton(
                child: Text("SIGN OUT"),
                onPressed: () {
                  Auth.instance.logOut(context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

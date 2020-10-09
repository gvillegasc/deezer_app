import 'dart:io';

import 'package:deezer_app/libs/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Widget _getAlias(String displayName) {
    final List<String> tmp = displayName.split(" ");
    String alias = "";
    if (tmp.length > 0) {
      alias = tmp[0][0];
      if (tmp.length == 2) {
        alias += tmp[1][0];
      }
    }
    return Center(
      child: Text(
        alias,
        style: TextStyle(fontSize: 30),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: CustomScrollView(
    //     slivers: <Widget>[
    //       HomeHeader(),
    //       SliverToBoxAdapter(
    //         child: Container(
    //           child: FlatButton(
    //             child: Text("SIGN OUT"),
    //             onPressed: () {
    //               Auth.instance.logOut(context);
    //             },
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: SafeArea(
          child: FutureBuilder<User>(
            future: Auth.instance.user,
            builder: (BuildContext _, AsyncSnapshot<User> snapshot) {
              if (snapshot.hasData) {
                final User user = snapshot.data;

                return ListView(
                  children: <Widget>[
                    CircleAvatar(
                        radius: 40,
                        child: (user.photoURL != null)
                            ? ClipOval(
                                child: Image.network(
                                  user.photoURL,
                                  width: 75,
                                  height: 75,
                                  fit: BoxFit.contain,
                                ),
                              )
                            : _getAlias(user.displayName)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      user.displayName,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      user.email,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CupertinoButton(
                      child: Text("Log out"),
                      onPressed: () {
                        Auth.instance.logOut(context);
                      },
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Network error"),
                );
              }
              return Center(
                child: (Platform.isAndroid)
                    ? CircularProgressIndicator()
                    : CupertinoActivityIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}

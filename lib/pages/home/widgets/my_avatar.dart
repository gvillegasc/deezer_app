import 'dart:io';

import 'package:deezer_app/libs/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAvatar extends StatelessWidget {
  final VoidCallback onPressed;

  const MyAvatar({Key key, @required this.onPressed})
      : assert(onPressed != null),
        super(key: key);

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
        style: TextStyle(
            fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: Auth.instance.user,
      builder: (BuildContext _, AsyncSnapshot<User> snapshot) {
        if (snapshot.hasData) {
          final User user = snapshot.data;

          return CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: this.onPressed,
            child: CircleAvatar(
                radius: 30,
                backgroundColor: Color(0xfff50057),
                child: (user.photoURL != null)
                    ? ClipOval(
                        child: Image.network(
                          user.photoURL,
                          width: 58,
                          height: 58,
                          fit: BoxFit.contain,
                        ),
                      )
                    : _getAlias(user.displayName)),
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
    );
  }
}

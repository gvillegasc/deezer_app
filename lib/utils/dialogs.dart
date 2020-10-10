import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static void alert(BuildContext context, {String title, String description}) {
    showDialog(
        context: context,
        child: (Platform.isIOS)
            ? CupertinoAlertDialog(
                title: title != null ? Text(title) : null,
                content: description != null ? Text(description) : null,
                actions: [
                    CupertinoDialogAction(
                      child: Text("OK"),
                      onPressed: () => Navigator.pop(context),
                    )
                  ])
            : AlertDialog(
                title: title != null
                    ? Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    : null,
                content: description != null
                    ? Text(
                        description,
                      )
                    : null,
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      'OK',
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ));
  }
}

class ProgressDialog {
  final BuildContext context;

  ProgressDialog(this.context);

  void show() {
    showCupertinoModalPopup(
        context: this.context,
        builder: (_) => Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.3),
            child: Center(
              child: (Platform.isIOS)
                  ? CupertinoActivityIndicator(
                      radius: 15,
                    )
                  : CircularProgressIndicator(),
            )));
  }

  void dismiss() {
    Navigator.pop(context);
  }
}

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

import 'package:deezer_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Widgets
import 'package:deezer_app/pages/login/widgets/welcome.dart';
import 'package:deezer_app/pages/login/widgets/login_form.dart';

import 'package:after_layout/after_layout.dart';

class LoginPage extends StatefulWidget {
  static final routeName = 'login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with AfterLayoutMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    final bool isTable = MediaQuery.of(context).size.shortestSide >= 600;
    if (!isTable) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: OrientationBuilder(
              builder: (_, Orientation orientation) {
                if (orientation == Orientation.portrait) {
                  return SingleChildScrollView(
                    child: Container(
                      height: responsive.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[Welcome(), LoginForm()],
                      ),
                    ),
                  );
                } else {
                  return Row(
                    children: <Widget>[
                      Expanded(
                        child: SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            child: Container(
                              padding: EdgeInsets.only(left: 20),
                              height: responsive.height,
                              child: Center(
                                child: Welcome(),
                              ),
                            )),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(child: Center(child: LoginForm())),
                        ),
                      )
                    ],
                  );
                }
              },
            )),
      ),
    );
  }
}

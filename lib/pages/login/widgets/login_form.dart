import 'package:deezer_app/libs/auth.dart';
import 'package:deezer_app/pages/home/home_page.dart';
import 'package:deezer_app/utils/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//  Widgets
import 'package:deezer_app/pages/login/widgets/input_text_login.dart';
import 'package:deezer_app/widgets/rounded_button.dart';
import 'package:deezer_app/widgets/circle_button.dart';

class LoginForm extends StatelessWidget {
  final VoidCallback onGoToRegister;
  final VoidCallback onGoToForgotPassword;

  const LoginForm(
      {Key key,
      @required this.onGoToRegister,
      @required this.onGoToForgotPassword})
      : super(key: key);

  void _goTo(BuildContext context, User user) {
    if (user != null) {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    } else {
      print("Login failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        top: false,
        child: Container(
          width: 280,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InputTextLogin(
                iconPath: 'assets/pages/login/icons/email.svg',
                placeholder: 'Email Address',
              ),
              SizedBox(
                height: responsive.ip(2),
              ),
              InputTextLogin(
                iconPath: 'assets/pages/login/icons/key.svg',
                placeholder: 'Password',
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: CupertinoButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text("Forgot password",
                      style: TextStyle(fontFamily: 'Sans')),
                  onPressed: onGoToForgotPassword,
                ),
              ),
              SizedBox(
                height: responsive.ip(2),
              ),
              RoundedButton(
                label: "Sign In",
                onPressed: onGoToRegister,
              ),
              SizedBox(
                height: responsive.ip(3),
              ),
              Text("Or continue with"),
              SizedBox(
                height: responsive.ip(1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleButton(
                    iconPath: "assets/pages/login/icons/facebook.svg",
                    onPressed: () async {
                      final User user = await Auth.instance.facebook(context);
                      _goTo(context, user);
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CircleButton(
                    iconPath: "assets/pages/login/icons/google.svg",
                    backgroundColor: Color(0xffD50000),
                    onPressed: () async {
                      final User user = await Auth.instance.google(context);
                      _goTo(context, user);

                      print("Listo");
                    },
                  ),
                ],
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an account?"),
                    CupertinoButton(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontFamily: 'Sans'),
                      ),
                      onPressed: onGoToRegister,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

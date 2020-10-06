import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//  Widgets
import 'package:deezer_app/pages/login/widgets/input_text_login.dart';
import 'package:deezer_app/widgets/rounded_button.dart';
import 'package:deezer_app/widgets/circle_button.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InputTextLogin(
            iconPath: 'assets/pages/login/icons/email.svg',
            placeholder: 'Email Address',
          ),
          SizedBox(
            height: 20,
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
              child:
                  Text("Forgot password", style: TextStyle(fontFamily: 'Sans')),
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: 20,
          ),
          RoundedButton(
            label: "Sign In",
            onPressed: () {},
          ),
          SizedBox(
            height: 20,
          ),
          Text("Or continue with"),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleButton(
                iconPath: "assets/pages/login/icons/facebook.svg",
              ),
              SizedBox(
                width: 20,
              ),
              CircleButton(
                iconPath: "assets/pages/login/icons/google.svg",
                backgroundColor: Color(0xffD50000),
              ),
            ],
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}

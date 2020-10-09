import 'package:deezer_app/libs/auth.dart';
import 'package:deezer_app/pages/home/home_page.dart';
import 'package:deezer_app/utils/app_colors.dart';
import 'package:deezer_app/utils/responsive.dart';
import 'package:deezer_app/widgets/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//  Widgets
import 'package:deezer_app/pages/login/widgets/input_text_login.dart';

class RegisterForm extends StatefulWidget {
  final VoidCallback onGoToLogin;

  const RegisterForm({Key key, @required this.onGoToLogin}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool _agree = false;

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
          padding: EdgeInsets.symmetric(horizontal: 15),
          constraints: BoxConstraints(
            maxWidth: 400,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "New Account",
                style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Raleway'),
              ),
              Text(
                "Id pariatur do nisi in nullaa qui exercitation quis Lorem mollit qui ut id.",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: responsive.ip(2),
              ),
              InputTextLogin(
                iconPath: 'assets/pages/login/icons/email.svg',
                placeholder: 'Username',
              ),
              SizedBox(
                height: responsive.ip(2),
              ),
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
              SizedBox(
                height: responsive.ip(2),
              ),
              InputTextLogin(
                iconPath: 'assets/pages/login/icons/key.svg',
                placeholder: 'Confirm Password',
              ),
              SizedBox(
                height: responsive.ip(2),
              ),
              DefaultTextStyle(
                style: TextStyle(
                    fontSize: responsive.ip(1.5),
                    color: Theme.of(context).textTheme.subtitle1.color),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    Checkbox(
                      value: _agree,
                      onChanged: (isChecked) {
                        setState(() {
                          _agree = isChecked;
                        });
                      },
                    ),
                    Text("I Agree to the "),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "Terms of services",
                        style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(" & "),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "Privacy Policy",
                        style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: responsive.ip(2),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back,
                          size: 20,
                        ),
                        Text("Back to Log In"),
                      ],
                    ),
                    onPressed: widget.onGoToLogin,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  RoundedButton(
                    label: "Sign Up",
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(
                height: responsive.ip(2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

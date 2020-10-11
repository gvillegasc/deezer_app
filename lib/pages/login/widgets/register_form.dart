import 'package:deezer_app/libs/auth.dart';
import 'package:deezer_app/pages/home/home_page.dart';
import 'package:deezer_app/utils/app_colors.dart';
import 'package:deezer_app/utils/dialogs.dart';
import 'package:deezer_app/utils/extras.dart';
import 'package:deezer_app/utils/responsive.dart';
import 'package:deezer_app/widgets/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//  Widgets
import 'package:deezer_app/pages/login/widgets/input_text_login.dart';

class RegisterForm extends StatefulWidget {
  final Alignment alignment;
  final VoidCallback onGoToLogin;

  const RegisterForm({Key key, @required this.onGoToLogin, this.alignment})
      : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool _agree = false;

  final GlobalKey<InputTextLoginState> _usernameKey = GlobalKey();
  final GlobalKey<InputTextLoginState> _emailKey = GlobalKey();
  final GlobalKey<InputTextLoginState> _passwordKey = GlobalKey();
  final GlobalKey<InputTextLoginState> _vpasswordKey = GlobalKey();

  void _goTo(User user) {
    if (user != null) {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    } else {
      print("Register failed");
    }
  }

  _submit() async {
    final String username = _usernameKey.currentState.value;
    final String email = _emailKey.currentState.value;
    final String password = _passwordKey.currentState.value;
    // final String vpassword = _vpasswordKey.currentState.value;

    final bool usernameOk = _usernameKey.currentState.isOk;
    final bool emailOk = _emailKey.currentState.isOk;
    final bool passwordOk = _passwordKey.currentState.isOk;
    final bool vpasswordOk = _vpasswordKey.currentState.isOk;

    if (usernameOk && emailOk && passwordOk && vpasswordOk) {
      if (_agree) {
        final User user = await Auth.instance.signUp(context,
            username: username, email: email, password: password);

        _goTo(user);
      } else {
        Dialogs.alert(context,
            title: "Aviso",
            description: 'You need to accept the terms and conditions');
      }
    } else {
      Dialogs.alert(context,
          title: "Aviso", description: 'Some fields are invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Align(
      alignment: widget.alignment,
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
                key: _usernameKey,
                iconPath: 'assets/pages/login/icons/email.svg',
                placeholder: 'Username',
                validator: (text) {
                  return text.trim().length > 0;
                },
              ),
              SizedBox(
                height: responsive.ip(2),
              ),
              InputTextLogin(
                key: _emailKey,
                iconPath: 'assets/pages/login/icons/email.svg',
                placeholder: 'Email Address',
                keyboardType: TextInputType.emailAddress,
                validator: (text) {
                  return text.contains('@');
                },
              ),
              SizedBox(
                height: responsive.ip(2),
              ),
              InputTextLogin(
                key: _passwordKey,
                iconPath: 'assets/pages/login/icons/key.svg',
                placeholder: 'Password',
                obscureText: true,
                validator: (text) => Extras.isValidEmail(text),
              ),
              SizedBox(
                height: responsive.ip(2),
              ),
              InputTextLogin(
                key: _vpasswordKey,
                iconPath: 'assets/pages/login/icons/key.svg',
                placeholder: 'Confirm Password',
                obscureText: true,
                validator: (text) {
                  return text.trim().length >= 6 &&
                      _vpasswordKey.currentState.value ==
                          _passwordKey.currentState.value;
                },
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
                    onPressed: _submit,
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

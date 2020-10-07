import 'package:deezer_app/pages/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Auth {
  Auth._internal();
  static Auth get instance => Auth._internal();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User> get user async {
    return _firebaseAuth.currentUser;
  }

  Future<User> google() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication authentication =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken);

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      final User user = userCredential.user;
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<void> facebook2() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == 200) {
        print("Facebook login ok");
        final userData = await FacebookAuth.instance.getUserData();
        print(userData);
      } else if (result.status == 403) {
        print("Facebook login cancelled");
      } else {
        print("Facebook login failed");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<User> facebook() async {
    try {
      final facebookLogin = new FacebookLogin();
      facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
      final facebookLoginResult = await facebookLogin.logIn(['email']);
      switch (facebookLoginResult.status) {
        case FacebookLoginStatus.loggedIn:
          final AuthCredential credential = FacebookAuthProvider.credential(
              facebookLoginResult.accessToken.token);

          final UserCredential userCredential =
              await _firebaseAuth.signInWithCredential(credential);
          final User user = userCredential.user;
          return user;
        case FacebookLoginStatus.cancelledByUser:
          // onLoginStatusChanged(false);
          return null;
        case FacebookLoginStatus.error:
          // onLoginStatusChanged(false);
          return null;
        default:
          return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> logOut(BuildContext context) async {
    final List<UserInfo> providers = (await user).providerData;
    String providerId = "firebase";
    for (final p in providers) {
      if (p.providerId != 'firebase') {
        providerId = p.providerId;
        break;
      }
    }
    switch (providerId) {
      case "facebook.com":
        await FacebookAuth.instance.logOut();
        break;
      case "google.com":
        await _googleSignIn.signOut();
        break;
      case "password":
        break;
      case "phone":
        break;
      default:
    }
    await _firebaseAuth.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, LoginPage.routeName, (_) => false);
  }
}

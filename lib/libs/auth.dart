import 'package:deezer_app/pages/login/login_page.dart';
import 'package:deezer_app/utils/dialogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
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

  Future<User> google(BuildContext context) async {
    ProgressDialog progressDialog = ProgressDialog(context);
    try {
      progressDialog.show();
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication authentication =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken);

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      final User user = userCredential.user;
      progressDialog.dismiss();
      return user;
    } catch (e) {
      progressDialog.dismiss();

      return null;
    }
  }

  Future<User> signUp(BuildContext context,
      {@required String username,
      @required String email,
      @required String password}) async {
    ProgressDialog progressDialog = ProgressDialog(context);
    try {
      progressDialog.show();

      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        await userCredential.user.updateProfile(displayName: username);
        progressDialog.dismiss();
        return userCredential.user;
      }
      progressDialog.dismiss();
      return null;
    } catch (e) {
      print(e.code);
      String message = "Unknown error";

      if (e.code == "email-already-in-use" ||
          e.code == "ERROR_EMAIL_ALREADY_IN_USE") {
        message = e.message;
      }
      progressDialog.dismiss();
      Dialogs.alert(context, title: 'ERROR', description: message);

      return null;
    }
  }

  Future<User> facebook(BuildContext context) async {
    ProgressDialog progressDialog = ProgressDialog(context);
    try {
      progressDialog.show();
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
          progressDialog.dismiss();
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
      progressDialog.show();
      return null;
    }
  }

  Future<bool> sendResetEmailLink(BuildContext context,
      {@required String email}) async {
    ProgressDialog progressDialog = ProgressDialog(context);

    try {
      progressDialog.show();
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print(e);
      return false;
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

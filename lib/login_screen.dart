import 'package:firebase1/auth.dart';
import 'package:firebase1/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthFirebase auth;

  @override
  void initState() {
    super.initState();
    auth = AuthFirebase();
    auth.getUser().then((value) {
      MaterialPageRoute route;
      if (value != null) {
        route = MaterialPageRoute(
            builder: (context) => MyHome(
                  wid: value.uid,
                  email: value.email,
                ));
        Navigator.pushReplacement(context, route);
      }
    }).catchError((err) => print(err));
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
        onLogin: _loginUser,
        onRecoverPassword: _recoverPassword,
        onSignup: _onSignUp,
        passwordValidator: (value) {
          if (value != null) {
            if (value.length < 6) {
              return ("Password must be 6 characters");
            }
          }
        },
        loginProviders: <LoginProvider>[
          LoginProvider(
            icon: FontAwesomeIcons.google,
            label: "google",
            callback: _onLoginGoogle,
          )
        ],
        onSubmitAnimationCompleted: () {
          auth.getUser().then((value) {
            MaterialPageRoute route;
            if (value != null) {
              route = MaterialPageRoute(
                  builder: (context) => MyHome(
                        wid: value.uid,
                        email: value.email,
                      ));
            } else {
              route = MaterialPageRoute(builder: (context) => LoginScreen());
            }
            Navigator.pushReplacement(context, route);
          }).catchError((err) => print(err));
        });
  }

  Future<String?>? _loginUser(LoginData data) {
    return auth.login(data.name, data.password).then((value) {
      if (value != null) {
        MaterialPageRoute(
            builder: (context) => MyHome(
                  wid: value,
                  email: data.name,
                ));
      } else {
        final snackBar = SnackBar(
            content: const Text("Login Failed, USER Not Found"),
            action: SnackBarAction(label: 'OK', onPressed: () {}));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (content) => LoginScreen()));
      }
    });
  }

  Future<String?>? _recoverPassword(String name) {
    return null;
  }

  Future<String?>? _onSignUp(SignupData data) {
    return auth.signUp(data.name!, data.password!).then((value) {
      if (value != null) {
        final snackBar = SnackBar(
            content: const Text("Signup Successful"),
            action: SnackBarAction(label: 'OK', onPressed: () {}));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  Future<String?>? _onLoginGoogle() {
    return await auth.googleLogin();
  }
}

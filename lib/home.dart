import 'package:firebase1/auth.dart';
import 'package:firebase1/login_screen.dart';
import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key, required this.wid, required this.email});
  final String wid;
  final String? email;

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  late AuthFirebase auth;

  @override
  void initState() {
    super.initState();
    auth = AuthFirebase();
    auth.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            icon: const Icon(Icons.logout_sharp),
            tooltip: "LogOut",
            onPressed: () {
              auth.logout();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            }),
      ]),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("Welcomme ${widget.email}"), Text("ID ${widget.wid}")],
      )),
    );
  }
}

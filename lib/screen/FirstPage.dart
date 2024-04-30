import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:to_do/commun/button.dart';
import 'package:to_do/commun/logo.dart';
import 'package:to_do/screen/LogIn.dart';
import 'package:to_do/screen/SignUp.dart';

class MyHomePage extends StatelessWidget {
  final password_controller = TextEditingController();
  final UserName = TextEditingController();
  final password_controller_conf = TextEditingController();
  final email_controller = TextEditingController();

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey.shade100,
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const Logo(),
          const Gap(60),
          Button(
            Butontext: "Login",
            Pressed: LogIn(
                email_controller: email_controller,
                password_controller: password_controller,
                Butontext: "Login"),
          ),
          const Gap(25),
          Button(
            Butontext: "Register",
            Pressed: SignUp(
                UserName: UserName,
                email_controller: email_controller,
                password_controller: password_controller,
                password_controller_conf: password_controller_conf,
                Butontext: "Registre"),
          ),
        ]));
  }
}

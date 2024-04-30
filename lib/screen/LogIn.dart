// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:to_do/commun/TextField.dart';
import 'package:to_do/commun/logo.dart';
import 'package:to_do/provider/auth_provider.dart';

class LogIn extends ConsumerWidget {
  const LogIn({
    super.key,
    required this.email_controller,
    required this.password_controller,
    required this.Butontext,
  });

  final TextEditingController email_controller;
  final TextEditingController password_controller;
  final String Butontext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authSerice = ref.watch(authServiceProvider);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.95,
      child: Column(
        children: [
          const Logo(),
          const Gap(20),
          Container(
            color: Colors.white,
            child: TextFieldWidget(
              maxLines: 1,
              hintText: "email",
              textController: email_controller,
              isObscured: false,
              prefixIcon: Icons.email,
            ),
          ),
          const Gap(20),
          Container(
            color: Colors.white,
            child: TextFieldWidget(
              maxLines: 1,
              hintText: "password",
              isObscured: true,
              textController: password_controller,
              prefixIcon: Icons.password,
              suffIconData: Icons.remove_red_eye,
            ),
          ),
          const Gap(20),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 20),
              ),
              child: Text(
                Butontext,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlue,
                ),
              ),
              onPressed: () async {
                try {
                  Navigator.pop(context);
                  await authSerice.SignInWithEmailAndPassword(
                      email_controller.text, password_controller.text);
                  //print();
                } catch (e) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          title: Text("Error"),
                          content: Text("Wrong password"),
                        );
                      });
                }
              })
        ],
      ),
    );
  }
}

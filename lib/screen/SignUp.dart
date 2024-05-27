import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:to_do/commun/TextField.dart';
import 'package:to_do/commun/logo.dart';
import 'package:to_do/provider/auth_provider.dart';

class SignUp extends ConsumerWidget {
  const SignUp({
    super.key,
    required this.UserName,
    required this.email_controller,
    required this.password_controller,
    required this.password_controller_conf,
    required this.Butontext,
  });

  final TextEditingController UserName;
  final TextEditingController email_controller;
  final TextEditingController password_controller;
  final TextEditingController password_controller_conf;
  final String Butontext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authServiceProvider);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.95,
      child: Column(
        children: [
          const Logo(),
          const Gap(20),
          const Gap(20),
          Container(
            color: Colors.white,
            child: TextFieldWidget(
              maxLines: 1,
              hintText: "UserName",
              textController: UserName,
              isObscured: false,
              prefixIcon: Icons.person,
            ),
          ),
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
              textController: password_controller,
              isObscured: true,
              //hiden: true,
              prefixIcon: Icons.password,
              suffIconData: Icons.remove_red_eye,
            ),
          ),
          const Gap(20),
          Container(
            color: Colors.white,
            child: TextFieldWidget(
              maxLines: 1,
              hintText: "passwordConfirm",
              textController: password_controller_conf,
              isObscured: true,
              // hiden: true,
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
                  if (password_controller.text ==
                      password_controller_conf.text) {
                    await auth.createUserWithEmailAndPassword(
                        email_controller.text,
                        password_controller.text,
                        UserName.text);

                    Navigator.pop(context);
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            title: Text("Error"),
                            content: Text("Wrong password"),
                          );
                        });
                  }
                } catch (e) {
                  showDialog(
                      // ignore: use_build_context_synchronously
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          title: Text("Error"),
                          content: Text("this user already exists"),
                        );
                      });
                }
              })
        ],
      ),
    );
  }
}

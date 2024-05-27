// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:to_do/model/User.dart';
import 'package:to_do/screen/FirstPage.dart';
import 'package:to_do/screen/Home.dart';
import 'package:to_do/services/auth_services.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel?>(
      stream: AuthService().user,
      builder: (_, AsyncSnapshot<UserModel?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final UserModel? user = snapshot.data;

          if (user == null) {
            return MyHomePage();
          } else {
            print(user.name);

            return HomePage(
              userName: user.name,
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

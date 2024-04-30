import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/model/User.dart';
import 'package:to_do/provider/auth_provider.dart';
import 'package:to_do/screen/FirstPage.dart';
import 'package:to_do/screen/Home.dart';

class Wrapper extends ConsumerStatefulWidget {
  const Wrapper({super.key});
  @override
  ConsumerState<Wrapper> createState() => WrapperState();
}

class WrapperState extends ConsumerState<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final authService = ref.watch(authServiceProvider);
    return StreamBuilder<UserModel?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<UserModel?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final UserModel? user = snapshot.data;
          if (user == null) {
            return MyHomePage();
          } else {
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

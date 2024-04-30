import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/provider/password_provider.dart';

class TextFieldWidget extends ConsumerWidget {
  // ConsumerWidget pour utiliser Riverpod
  const TextFieldWidget({
    super.key,
    required this.maxLines,
    required this.hintText,
    required this.textController,
    this.prefixIcon,
    this.suffIconData,
    this.isObscured = false,
  });

  final String hintText;
  final int maxLines;
  final TextEditingController textController;
  final IconData? prefixIcon;
  final IconData? suffIconData;
  final bool isObscured;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool obscureState = isObscured ? ref.watch(obscureProvider) : false;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: textController,
        obscureText: obscureState,
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon),
          suffixIcon: suffIconData != null && isObscured
              ? IconButton(
                  icon: Icon(
                    obscureState ? suffIconData : Icons.visibility,
                  ),
                  onPressed: () {
                    ref.read(obscureProvider.notifier).state = !obscureState;
                  },
                )
              : null,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: hintText,
        ),
        maxLines: maxLines,
      ),
    );
  }
}

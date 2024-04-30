import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.Butontext, required this.Pressed});
  final String Butontext;
  final Widget Pressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        width: 250,
        color: Colors.blueGrey.shade100,
        child: ElevatedButton(
          onPressed: () => showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return Pressed;
              }),
          child: Text(
            Butontext,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.lightBlue,
            ),
          ),
        ),
      ),
    );
  }
}

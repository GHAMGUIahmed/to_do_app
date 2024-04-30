import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width / 8,
              height: MediaQuery.of(context).size.height / 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: const DecorationImage(
                  image: AssetImage("assets/logo.png"),
                ),
              )),
          const Gap(20),
          Text(
            "To DO",
            style: TextStyle(
              fontSize: 70,
              fontWeight: FontWeight.w900,
              color: Colors.blueAccent.shade700,
            ),
          ),
          const Gap(8),
          Text(
            "Get things Done",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.blueAccent.shade700,
            ),
          ),
        ],
      ),
    );
  }
}

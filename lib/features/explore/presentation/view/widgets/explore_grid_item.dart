import 'package:flutter/material.dart';
import 'package:hakawati/core/utils/utils.dart';

class ExploreViewGridItem extends StatelessWidget {
  const ExploreViewGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: context.width * .2 - 10,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.deepPurple, Colors.purple],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              Assets.testImageThree,
              height: 130,
            ),
            Text("Explore", style: Styles.fontStyle16(context).copyWith(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

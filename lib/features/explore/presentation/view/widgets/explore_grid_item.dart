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
        //   gradient: const LinearGradient(
        //     colors: [Colors.deepPurple, Colors.purple],
        //     begin: Alignment.bottomLeft,
        //     end: Alignment.topRight,
        //   ),
        color: AppColors.getRandomColor(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              Assets.testImageThree,
              height: 140,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                colors: [AppColors.gradientColor1, Colors.transparent],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Explore", style: Styles.fontStyle16(context).copyWith(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:hakawati/core/utils/styles.dart';

class StatisticsTexts extends StatelessWidget {
  const StatisticsTexts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Text("60", style: Styles.fontStyle24(context)),
          Text("Likes", style: Styles.fontStyle12(context)),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hakawati/core/utils/utils.dart';
import 'package:hakawati/core/widgets/custom_elevated_icon_button.dart';

import 'gradient_foreground.dart';
import 'icon_chip.dart';
import '../story_details_view.dart';

class RecommendedStoriesListItem extends StatelessWidget {
  const RecommendedStoriesListItem(
      {super.key, this.itemWidth = 220, this.endPadding = 8.0, this.showTutorial = true, this.itemHeight});
  final double itemWidth;
  final double? itemHeight;
  final double endPadding;
  final bool showTutorial;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: endPadding),
      child: Container(
          width: itemWidth,
          height: itemHeight,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).secondaryHeaderColor, width: 0.3),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(Assets.testImageTwo),
              ),
              const GradientForeground(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tutorial',
                      style: Styles.fontStyle24(context).copyWith(fontWeight: FontWeight.bold),
                    ),
                    if (showTutorial) ...[
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Lorem ipsum is just a random word used',
                        style: Styles.fontStyle16(context),
                      ),
                    ],
                    const SizedBox(
                      height: 5,
                    ),
                    CustomElevatedIconButton(
                      icon: FontAwesomeIcons.readme,
                      onPressed: () {
                        context.go(const StoryDetailView());
                      },
                      borderSide: BorderSide(width: 1, color: Theme.of(context).secondaryHeaderColor),
                      iconSize: 18,
                      child: Text(
                        ' Read',
                        style: Styles.fontStyle16(context).copyWith(
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const PositionedDirectional(
                start: 0,
                top: 0,
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: IconChip(
                    icon: Icon(FontAwesomeIcons.book, size: 20),
                    title: '30',
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

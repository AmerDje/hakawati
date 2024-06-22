import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hakawati/core/utils/utils.dart';

import 'genre_text.dart';
import 'gradient_foreground.dart';
import 'icon_chip.dart';

class StoriesHistoryListItem extends StatelessWidget {
  const StoriesHistoryListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 8.0),
      child: Container(
          width: 220,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).secondaryHeaderColor, width: 0.3),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  // child: ColorFiltered(
                  //   colorFilter: ColorFilter.mode(Colors.purple.withOpacity(.5), BlendMode.hardLight),
                  child: Image.asset(Assets.testImageThree),
                  //),
                ),
              ),
              const GradientForeground(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Walk on moon',
                        style: Styles.fontStyle22(context).copyWith(
                          fontWeight: FontWeight.bold,
                          // shadows: [
                          //   const Shadow(
                          //     blurRadius: 10.0,
                          //     color: Colors.black,
                          //     offset: Offset(2.0, 2.0),
                          //   ),
                          // ],
                        )),
                    const GenreText(genre: 'Space')
                  ],
                ),
              ),
              const PositionedDirectional(
                start: 0,
                top: 0,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
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

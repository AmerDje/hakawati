import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hakawati/core/utils/utils.dart';

import 'genre_text.dart';
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
            border: Border.all(color: Colors.white, width: 0.5),
            borderRadius: BorderRadius.circular(15.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(Colors.purple.withOpacity(.5), BlendMode.hardLight),
                    child: Image.asset(Assets.testImageThree),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Walk on moon', style: Styles.fontStyle22(context).copyWith(fontWeight: FontWeight.bold)),
                  const GenreText(genre: 'Space')
                ],
              ),
              const PositionedDirectional(
                start: 0,
                top: 0,
                child: IconChip(
                  icon: Icon(FontAwesomeIcons.book, size: 20),
                  title: '30',
                ),
              ),
            ],
          )),
    );
  }
}

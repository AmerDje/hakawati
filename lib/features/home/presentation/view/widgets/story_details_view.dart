import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hakawati/core/utils/utils.dart';
import 'package:hakawati/core/widgets/widgets.dart';
import 'package:hakawati/features/home/presentation/view/widgets/genre_text.dart';
import 'package:hakawati/features/settings/presentation/views/settings/view/widgets/appbar_leading_button.dart';

import 'add_favorite_button.dart';
import 'icon_chip.dart';

class StoryDetailView extends StatelessWidget {
  const StoryDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GradientScaffold(
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
              child: Column(
                children: [
                  Container(
                      height: context.height * 0.6,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                        Assets.testImageTwo,
                      )))),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconChip(icon: Icon(FontAwesomeIcons.book, size: 20), title: '30'),
                      SizedBox(width: 10),
                      IconChip(icon: Icon(FontAwesomeIcons.download, size: 20), title: '30Mb'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const GenreText(genre: 'Space'),
                  const Spacer(),
                  Text('Walk in Mars', style: Styles.fontStyle32(context)),
                  Text(
                    'Lorem ipsum is just a random word Lorem ipsum is just a random word used Lorem ipsum is just a random word used',
                    style: Styles.fontStyle18(context),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: CustomElevatedButton(
                              onPressed: () {},
                              child: Text('Read',
                                  style: Styles.fontStyle16(context)
                                      .copyWith(color: Theme.of(context).secondaryHeaderColor)))),
                      const SizedBox(width: 10),
                      Expanded(
                          child: CustomElevatedIconButton(
                              text: 'Download', onPressed: () {}, icon: FontAwesomeIcons.download)),
                    ],
                  ),
                ],
              ),
            ),
            const PositionedDirectional(
              start: 5,
              top: 0,
              child: AppBarLeadingButton(),
            ),
            AddFavoriteButton(
              onAddFav: () {
                debugPrint("Tapped");
              },
              onRemoveFav: () {
                debugPrint("removed");
              },
            )
          ],
        ),
      ),
    );
  }
}

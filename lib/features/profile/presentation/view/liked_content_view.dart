import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hakawati/config/locale/localization/app_localizations.dart';
import 'package:hakawati/core/utils/utils.dart';
import 'package:hakawati/core/widgets/custom_elevated_icon_button.dart';
import 'package:hakawati/core/widgets/gradient_scaffold.dart';
import 'package:hakawati/core/widgets/search_app_bar.dart';
import 'package:hakawati/features/home/presentation/view/widgets/add_favorite_button.dart';
import 'package:hakawati/features/home/presentation/view/widgets/gradient_foreground.dart';
import 'package:hakawati/features/home/presentation/view/widgets/icon_chip.dart';
import 'package:hakawati/features/home/presentation/view/story_details_view.dart';

class LikedContentView extends StatelessWidget {
  const LikedContentView({super.key});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!.translate;
    return GradientScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        forceMaterialTransparency: true,
        leading: const SizedBox(),
        flexibleSpace: SearchAppBar(onChanged: (value) {}),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(translate("All Stories"), style: Styles.fontStyle32(context)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return FavoriteContentListItem(
                    endPadding: 10,
                    showTutorial: true,
                    itemWidth: context.width,
                    itemHeight: 200,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteContentListItem extends StatelessWidget {
  const FavoriteContentListItem(
      {super.key, this.itemWidth = 220, this.endPadding = 8.0, this.showTutorial = true, this.itemHeight});
  final double itemWidth;
  final double? itemHeight;
  final double endPadding;
  final bool showTutorial;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(bottom: endPadding),
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
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: CustomElevatedIconButton(
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
              PositionedDirectional(
                end: 0,
                top: 0,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: AddFavoriteButton(
                    onAddFav: () {
                      debugPrint("Tapped");
                    },
                    onRemoveFav: () {
                      debugPrint("removed");
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

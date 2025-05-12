import 'package:flutter/material.dart';
import 'package:hakawati/config/locale/localization/app_localizations.dart';
import 'package:hakawati/core/utils/utils.dart';
import 'package:hakawati/core/widgets/search_app_bar.dart';
import 'package:hakawati/core/widgets/widgets.dart';

import 'widgets/recommended_stories_list_item.dart';

class RecommendedStoriesListView extends StatelessWidget {
  const RecommendedStoriesListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return const RecommendedStoriesListItem();
        },
      ),
    );
  }
}

class RecommendedStoriesVerticalList extends StatelessWidget {
  const RecommendedStoriesVerticalList({super.key});

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
              child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1 / 1.5,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const RecommendedStoriesListItem(
                    endPadding: 0,
                    showTutorial: false,
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

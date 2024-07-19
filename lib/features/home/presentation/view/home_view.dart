import 'package:flutter/material.dart';
import 'package:hakawati/config/locale/locale.dart';
import 'package:hakawati/core/utils/extensions/navigator.dart';
import 'package:hakawati/core/widgets/gradient_scaffold.dart';
import 'package:hakawati/features/personalize/presentation/view/personalize_view.dart';
import 'widgets/app_bar_icon.dart';
import 'widgets/icon_chip.dart';
import 'widgets/recommended_stories_list_view.dart';
import 'widgets/stories_history_list_view.dart';
import 'widgets/stories_list_header.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)?.translate;
    return SafeArea(
      minimum: const EdgeInsets.only(top: 10),
      child: GradientScaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            child: IconChip(
              icon: const Icon(
                Icons.star,
                color: Colors.yellow,
                size: 30,
              ),
              onPressed: () {
                context.go(const PersonalizeView());
              },
              title: 'AI',
            ),
          ),
          leadingWidth: 90,
          actions: [
            AppBarIcon(
              icon: Icons.history,
              onPressed: () {},
            ),
            const SizedBox(width: 10),
            AppBarIcon(
              icon: Icons.favorite,
              onPressed: () {},
            ),
            const SizedBox(width: 5),
          ],
          // bottom: PreferredSize(
          //     preferredSize: const Size.fromHeight(50),
          //     child: Align(
          //       alignment: Alignment.centerLeft,
          //       child: Wrap(
          //           children: List.generate(
          //         3,
          //         (index) => Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //           child: AppBarChip(
          //             chipModel: ChipModel(
          //               title: 'Chip $index',
          //               index: index,
          //             ),
          //           ),
          //         ),
          //       )),
          //     ))
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StoriesListHeader(headTitle: translate!('We Recommend'), onViewAllPressed: () {}),
                const SizedBox(height: 20),
                const RecommendedStoriesListView(),
                const SizedBox(height: 40),
                StoriesListHeader(headTitle: translate('History'), onViewAllPressed: () {}),
                const SizedBox(height: 20),
                const StoriesHistoryListView(),
                const SizedBox(height: 80),
                // const ToggleTheme(),
                // Text(translate('welcome')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

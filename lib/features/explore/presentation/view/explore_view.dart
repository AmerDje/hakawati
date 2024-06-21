import 'package:flutter/material.dart';
import 'package:hakawati/config/locale/locale.dart';
import 'package:hakawati/core/utils/utils.dart';
import 'package:hakawati/core/widgets/widgets.dart';

import 'widgets/explore_grid_view.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!.translate;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              CustomTextField(
                icon: const Icon(Icons.search),
                hintText: translate("Search"),
              ),
              const SizedBox(height: 20),
              Text(translate("Browse all"), style: Styles.fontStyle32(context)),
              const SizedBox(height: 20),
              const ExploreGridView(),
            ],
          ),
        ),
      ),
    );
  }
}

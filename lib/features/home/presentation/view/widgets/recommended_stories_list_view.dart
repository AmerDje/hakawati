import 'package:flutter/material.dart';

import 'recommended_stories_list_item.dart';

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

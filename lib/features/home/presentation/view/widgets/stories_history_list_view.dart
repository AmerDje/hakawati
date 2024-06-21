import 'package:flutter/material.dart';

import 'stories_history_list_item.dart';

class StoriesHistoryListView extends StatelessWidget {
  const StoriesHistoryListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return const StoriesHistoryListItem();
        },
      ),
    );
  }
}

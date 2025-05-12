import 'package:flutter/material.dart';

import 'explore_grid_item.dart';

class ExploreGridView extends StatelessWidget {
  const ExploreGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
          itemCount: 10,
          padding: const EdgeInsets.only(bottom: 80),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return const ExploreViewGridItem();
          }),
    );
  }
}

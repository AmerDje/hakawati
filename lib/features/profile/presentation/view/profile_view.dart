import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hakawati/core/widgets/gradient_scaffold.dart';
import 'package:hakawati/features/home/presentation/view/widgets/stories_history_list_view.dart';
import 'package:hakawati/features/home/presentation/view/widgets/stories_list_header.dart';

import 'widgets/profile_header.dart';
import 'widgets/profile_list_tile.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const ProfileHeader(),
              const SizedBox(height: 40),
              StoriesListHeader(
                headTitle: 'History',
                onViewAllPressed: () {},
              ),
              const SizedBox(height: 20),
              const StoriesHistoryListView(),
              const SizedBox(height: 20),
              ProfileListTile(
                title: "Liked Content",
                iconData: FontAwesomeIcons.heart,
                onPressed: () {},
              ),
              const SizedBox(height: 10),
              ProfileListTile(
                title: "Edit Profile",
                iconData: FontAwesomeIcons.userPen,
                onPressed: () {},
              ),
              const SizedBox(height: 10),
              ProfileListTile(
                title: "About Us",
                iconData: FontAwesomeIcons.userGroup,
                onPressed: () {},
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

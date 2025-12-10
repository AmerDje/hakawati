import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hakawati/core/utils/utils.dart';
import 'package:hakawati/features/profile/presentation/manager/profile_cubit.dart';
import 'package:hakawati/features/profile/presentation/view/edit_profile_view.dart';
import 'package:hakawati/features/profile/presentation/view/liked_content_view.dart';
import 'package:hakawati/features/profile/presentation/view/widgets/profile_list_tile.dart';

class ProfileTails extends StatelessWidget {
  const ProfileTails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileListTile(
          title: "Liked Content",
          iconData: FontAwesomeIcons.heart,
          onPressed: () {
            context.go(const LikedContentView());
          },
        ),
        const SizedBox(height: 10),
        ProfileListTile(
          title: "Edit Profile",
          iconData: FontAwesomeIcons.userPen,
          onPressed: () {
            context.go(BlocProvider.value(
              value: context.read<ProfileCubit>(),
              child: const EditProfileView(),
            ));
          },
        ),
        const SizedBox(height: 10),
        ProfileListTile(
          title: "About Us",
          iconData: FontAwesomeIcons.userGroup,
          onPressed: () {},
        ),
      ],
    );
  }
}

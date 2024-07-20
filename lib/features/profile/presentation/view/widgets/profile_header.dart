import 'package:flutter/material.dart';
import 'package:hakawati/core/utils/utils.dart';
import 'package:hakawati/features/profile/presentation/view/widgets/profile_image_view.dart';
import 'package:hakawati/features/profile/presentation/view/widgets/statistics_text.dart';
import 'package:hakawati/features/settings/presentation/views/settings/view/settings_view.dart';
import 'edge_button.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150,
          decoration: const ShapeDecoration(
            shape: StadiumBorder(),
            color: AppColors.gradientColor2,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 20),
              const ProfileImageView(),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Hi, User Name",
                      style: Styles.fontStyle26(context).copyWith(color: Theme.of(context).secondaryHeaderColor)),
                  const Row(
                    children: [
                      StatisticsTexts(),
                      SizedBox(
                        width: 20,
                      ),
                      StatisticsTexts(),
                    ],
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: EdgeButton(
            iconData: Icons.settings,
            onPressed: () {
              context.go(const SettingsView());
            },
          ),
        )
      ],
    );
  }
}

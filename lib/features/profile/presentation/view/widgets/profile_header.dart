

import 'package:flutter/material.dart';
import 'package:hakawati/core/utils/extensions/navigator.dart';
import 'package:hakawati/core/utils/styles.dart';
import 'package:hakawati/features/profile/presentation/view/widgets/statistics_text.dart';
import 'package:hakawati/features/settings/presentation/views/settings/view/settings_view.dart';

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
          decoration: const ShapeDecoration(shape: StadiumBorder(), color: Colors.indigo),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 20),
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 60,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 20,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 25,
                          )),
                    ),
                  ),
                ],
              ),
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
          child: CircleAvatar(
            radius: 20,
            child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  context.go(const SettingsView());
                },
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 25,
                )),
          ),
        )
      ],
    );
  }
}

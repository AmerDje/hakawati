import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakawati/core/services/service_locator.dart';
import 'package:hakawati/core/utils/utils.dart';
import 'package:hakawati/features/auth/data/models/user.dart';
import 'package:hakawati/features/auth/data/repository/auth_repository.dart';
import 'package:hakawati/features/auth/presentation/manager/auth_cubit.dart';
import 'package:hakawati/features/profile/presentation/manager/profile_cubit.dart';
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
    final UserModel user = context.read<AuthCubit>().state.user;
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
              BlocProvider(
                create: (context) => ProfileCubit(authRepository: sl.get<AuthRepository>()),
                child: const ProfileImageView(),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Hi, ${user.name!.split(' ')[0]}",
                    style: Styles.fontStyle26(context).copyWith(color: Theme.of(context).secondaryHeaderColor),
                  ),
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

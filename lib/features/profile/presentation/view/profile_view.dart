import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakawati/core/service/service_locator.dart';
import 'package:hakawati/core/utils/extensions/navigator.dart';
import 'package:hakawati/core/widgets/gradient_scaffold.dart';
import 'package:hakawati/features/auth/data/repository/auth_repository_impl.dart';
import 'package:hakawati/features/home/presentation/view/stories_history_list_view.dart';
import 'package:hakawati/features/home/presentation/view/widgets/stories_list_header.dart';
import 'package:hakawati/features/profile/presentation/manager/profile_cubit.dart';
import 'package:hakawati/features/profile/presentation/view/widgets/profile_tails_view.dart';

import 'widgets/profile_header.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => ProfileCubit(authRepository: sl.get<AuthRepositoryImpl>()),
      child: GradientScaffold(
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
                  onViewAllPressed: () {
                    context.go(const StoriesHistoryVerticalList());
                  },
                ),
                const SizedBox(height: 20),
                const StoriesHistoryListView(),
                const SizedBox(height: 20),
                const ProfileTails(),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

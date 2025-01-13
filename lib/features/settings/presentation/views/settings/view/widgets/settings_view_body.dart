import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hakawati/core/services/service_locator.dart';
import 'package:hakawati/core/utils/utils.dart';
import 'package:hakawati/core/widgets/widgets.dart';
import 'package:hakawati/features/auth/data/repository/auth_repository.dart';
import 'package:hakawati/features/auth/presentation/manager/auth_cubit.dart';
import 'package:hakawati/features/auth/presentation/views/login/view/login_view.dart';
import 'package:hakawati/features/profile/presentation/view/widgets/profile_list_tile.dart';
import 'package:hakawati/features/settings/presentation/manager/settings_cubit.dart';
import 'package:hakawati/features/settings/presentation/views/localization/view/language_bottom_sheet.dart';
import 'package:hakawati/features/settings/presentation/views/theme/theme.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          ProfileListTile(
            title: "Theme",
            subtitle: context.read<SettingsCubit>().isDarkMode ? 'Dark' : 'Light',
            iconData: FontAwesomeIcons.circleHalfStroke,
            trailing: const ThemeSwitch(),
          ),
          const SizedBox(height: 10),
          ProfileListTile(
            title: "Language",
            iconData: FontAwesomeIcons.globe,
            subtitle: Constants.kLanguages[Localizations.localeOf(context).languageCode],
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  useSafeArea: true,
                  backgroundColor: Theme.of(context).primaryColor,
                  builder: (context) => const LanguageBottomSheet());
            },
          ),
          const SizedBox(height: 10),
          ProfileListTile(
            title: "Privacy Policy",
            iconData: FontAwesomeIcons.shieldHalved,
            onPressed: () {},
          ),
          const SizedBox(height: 10),
          ProfileListTile(
            title: "Terms & Conditions",
            iconData: FontAwesomeIcons.scroll,
            onPressed: () {},
          ),
          const Spacer(flex: 2),
          SizedBox(
            width: context.width,
            child: CustomElevatedIconButton(
              icon: Icons.logout,
              backgroundColor: Colors.transparent,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: const Text('Sign Out'),
                          content: const Text('Are you sure you want to sign out?'),
                          actions: [
                            CustomTextButton(
                              onPressed: () {
                                context.read<AuthCubit>().logout();
                                Navigator.pop(ctx);
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => const LoginView()),
                                    (Route<dynamic> route) => false);
                                try {
                                  sl.get<AuthRepository>().logout();
                                } catch (_) {}
                              },
                              btnText: 'Sign Out',
                              applyUnderLine: false,
                            ),
                            CustomTextButton(
                              onPressed: () {
                                Navigator.pop(ctx);
                              },
                              btnText: 'Cancel',
                              applyUnderLine: false,
                            ),
                          ],
                        ));
              },
              child: Text(
                "Sign Out",
                style: Styles.fontStyle18(context).copyWith(
                  color: Theme.of(context).secondaryHeaderColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

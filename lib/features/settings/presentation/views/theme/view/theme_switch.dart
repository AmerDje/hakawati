import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakawati/core/utils/utils.dart';
import 'package:hakawati/features/settings/presentation/manager/settings_cubit.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
      activeColor: Theme.of(context).secondaryHeaderColor,
      thumbColor: WidgetStateProperty.all(AppColors.primaryColorDark),
      thumbIcon: WidgetStateProperty.all(context.read<SettingsCubit>().isDarkMode
          ? const Icon(Icons.dark_mode)
          : const Icon(
              Icons.light_mode,
              color: AppColors.secondaryColorDark,
            )),
      value: context.watch<SettingsCubit>().isDarkMode,
      onChanged: (value) {
        context.read<SettingsCubit>().toggleTheme();
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakawati/features/settings/presentation/manager/settings_cubit.dart';

class ToggleTheme extends StatelessWidget {
  const ToggleTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: context.watch<SettingsCubit>().isDarkMode,
      onChanged: (value) {
        context.read<SettingsCubit>().toggleTheme();
      },
      title: Text(
        "Dark Mode",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

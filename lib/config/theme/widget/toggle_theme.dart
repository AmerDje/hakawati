import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakawati/config/theme/theme.dart';

class ToggleTheme extends StatelessWidget {
  const ToggleTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: context.watch<ThemeCubit>().isDarkMode,
      onChanged: (value) {
        context.read<ThemeCubit>().toggleTheme(isToggled: value);
      },
      title: Text(
        "Dark Mode",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

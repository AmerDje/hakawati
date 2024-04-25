import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakawati/config/localization/manager/localization_cubit.dart';
import 'package:hakawati/core/utils/strings.dart';

class ChangeLocal extends StatelessWidget {
  const ChangeLocal({super.key});

  @override
  Widget build(BuildContext context) {
    final String currentLocale = context.read<LocalizationCubit>().currentLocale.languageCode;
    return Column(
      children: [
        ListTile(
          title: const Text('Language'),
          subtitle: Text(currentLocale),
          trailing: DropdownButton<String>(
            value: currentLocale,
            items: const [
              DropdownMenuItem<String>(
                value: Strings.englishCode,
                child: Text('English'),
              ),
              DropdownMenuItem<String>(
                value: Strings.arabicCode,
                child: Text('العربية'),
              ),
              DropdownMenuItem<String>(
                value: Strings.frenchCode,
                child: Text('Français'),
              ),
            ],
            onChanged: (String? newLanguageCode) {
              if (newLanguageCode != null) {
                context.read<LocalizationCubit>().setLocale(Locale(newLanguageCode));
              }
            },
          ),
        ),
      ],
    );
  }
}

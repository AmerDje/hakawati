

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hakawati/config/locale/locale.dart';
import 'package:hakawati/core/utils/utils.dart';
import 'package:hakawati/core/widgets/widgets.dart';
import 'package:hakawati/features/settings/presentation/manager/settings_cubit.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  final List options = AppLocalizationsSetup.supportedLocales.map((e) => e.languageCode).toList();
  String value = Constants.kDefaultLocale;
  final List option0 = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    value = Localizations.localeOf(context).languageCode;
  }

  @override
  Widget build(BuildContext context) {
    final locate = Localizations.localeOf(context).languageCode;
    final theme = Theme.of(context);
    final translate = AppLocalizations.of(context)!.translate;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (context, index) {
              var option = options[index];
              bool isSelect = (option == value);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minLeadingWidth: 20,
                        title: Text(
                          Constants.kLanguages[option] ?? '',
                          style:
                              theme.textTheme.bodyMedium?.copyWith(color: isSelect ? theme.secondaryHeaderColor : null),
                        ),
                        trailing: isSelect ? Icon(FontAwesomeIcons.check, color: theme.secondaryHeaderColor) : null,
                        onTap: () => setState(() {
                          value = option;
                          if (option0.isNotEmpty) {
                            option0[0] = option;
                          } else {
                            option0.add(option);
                          }
                        }),
                      ),
                    ),
                    (index == options.length - 1) ? const SizedBox() : const Divider(height: 1, thickness: 0.5),
                  ],
                ),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomElevatedButton(
            onPressed: () {
              if (value != locate) {
                context.read<SettingsCubit>().changeLanguage(value);
              }
              Navigator.pop(context);
            },
            child: Text(
              translate('settings:apply'),
              style: Styles.fontStyle16(context).copyWith(color: Theme.of(context).secondaryHeaderColor),
            ),
          ),
        ],
      ),
    );
  }
}

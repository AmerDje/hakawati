import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hakawati/config/localization/localization.dart';
import 'package:hakawati/core/widgets/customs.dart';
import 'package:hakawati/features/settings/presentation/manager/settings_cubit.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  final List options = AppLocalizationsSetup.supportedLocales.map((e) => e.languageCode).toList();
  String? _value = 'en';
  final List _option = [];
  @override
  Widget build(BuildContext context) {
    final locate = Localizations.localeOf(context).languageCode;
    final theme = Theme.of(context);
    final translate = AppLocalizations.of(context)!.translate;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: Icon(
                  FontAwesomeIcons.language,
                  size: 80,
                  color: theme.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            translate('auth:change_language') ?? 'Change Language',
            style: theme.textTheme.titleSmall,
          ),
          const SizedBox(
            height: 15,
          ),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: List.generate(
                  options.length,
                  (index) {
                    var option = options[index];
                    bool isSelect = option == _value;
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            option,
                            style: theme.textTheme.bodyText2?.copyWith(color: isSelect ? theme.primaryColor : null),
                          ),
                          trailing:
                              isSelect ? Icon(FontAwesomeIcons.check, color: theme.primaryColor) : const SizedBox(),
                          minLeadingWidth: 20,
                          contentPadding: EdgeInsets.zero,
                          onTap: () => setState(() {
                            _value = option;
                            if (_option.isNotEmpty) {
                              _option[0] = option;
                            } else {
                              _option.add(option);
                            }
                          }),
                        ),
                        const Divider(height: 1, thickness: 1),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: CustomElevatedButton(
              onPressed: () {
                if (_value != null && _value != locate) {
                  if (mounted) context.read<LocalizationCubit>().setLocale(Locale(_value!));
                }
                context.read<SettingsCubit>().closeTranslation();
              },
              child: Text(translate('common:text_apply') ?? 'Apply'),
            ),
          ),
        ],
      ),
    ));
  }
}

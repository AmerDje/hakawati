import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hakawati/config/locale/locale.dart';
import 'package:hakawati/core/utils/constants.dart';
import 'package:hakawati/core/utils/styles.dart';
import 'package:hakawati/core/widgets/widgets.dart';
import 'package:hakawati/features/settings/presentation/manager/settings_cubit.dart';

class ChangeLanguageView extends StatefulWidget {
  const ChangeLanguageView({super.key});

  static const routeName = '/change_language_view';

  @override
  State<ChangeLanguageView> createState() => _ChangeLanguageViewState();
}

class _ChangeLanguageViewState extends State<ChangeLanguageView> {
  final List supportedLocales = AppLocalizationsSetup.supportedLocales.map((e) => e.languageCode).toList();
  String selectedLocal = Constants.kDefaultLocale;
  // final List _option = [];
  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context).languageCode;
    final theme = Theme.of(context);
    final translate = AppLocalizations.of(context)!.translate;
    return GradientScaffold(
        body: Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
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
            translate('change_language'),
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
              child: StatefulBuilder(builder: (context, setState) {
                return Column(
                  children: List.generate(
                    supportedLocales.length,
                    (index) {
                      var supportedLocaleItem = supportedLocales[index];
                      bool isSelect = (supportedLocaleItem == selectedLocal);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ListTile(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            title: Text(
                              translate(supportedLocaleItem),
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: isSelect ? theme.secondaryHeaderColor : null),
                              textAlign: TextAlign.center,
                            ),
                            trailing: isSelect
                                ? Icon(FontAwesomeIcons.check, color: theme.secondaryHeaderColor)
                                : const SizedBox(),
                            minLeadingWidth: 20,
                            horizontalTitleGap: 0,
                            contentPadding: EdgeInsets.zero,
                            onTap: () => setState(() {
                              selectedLocal = supportedLocaleItem;
                              // if (_option.isNotEmpty) {
                              //   _option[0] = option;
                              // } else {
                              //   _option.add(option);
                              // }
                            }),
                          ),
                          if (index != supportedLocales.length - 1)
                            const Divider(height: 1, thickness: 1, color: Colors.grey, indent: 30, endIndent: 30),
                        ],
                      );
                    },
                  ),
                );
              }),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: CustomElevatedButton(
              onPressed: () {
                if (selectedLocal != currentLocale) {
                  if (mounted) context.read<SettingsCubit>().changeLanguage(selectedLocal);
                }
                context.read<SettingsCubit>().closeTranslation();
              },
              child: Text(
                translate('apply'),
                style: Styles.fontStyle16(context).copyWith(color: Theme.of(context).secondaryHeaderColor),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

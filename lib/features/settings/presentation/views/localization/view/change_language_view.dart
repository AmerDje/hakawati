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
  final List options = AppLocalizationsSetup.supportedLocales.map((e) => e.languageCode).toList();
  String _value = Constants.kDefaultLocale;
  final List _option = [];
  @override
  Widget build(BuildContext context) {
    final locate = Localizations.localeOf(context).languageCode;
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
            translate('settings:change_language'),
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
                    bool isSelect = (option == locate);
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            option,
                            style: theme.textTheme.bodyMedium?.copyWith(color: isSelect ? theme.primaryColor : null),
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
                if (_value != locate) {
                  if (mounted) context.read<SettingsCubit>().changeLanguage(_value);
                }
                context.read<SettingsCubit>().closeTranslation();
              },
              child: Text(
                translate('settings:apply'),
                style: Styles.fontStyle16(context).copyWith(color: Theme.of(context).secondaryHeaderColor),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

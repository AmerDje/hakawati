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
  final List supportedLocals = AppLocalizationsSetup.supportedLocales.map((e) => e.languageCode).toList();
  late String locale;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    locale = Localizations.localeOf(context).languageCode;
  }

  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context).languageCode;
    final theme = Theme.of(context);
    final translate = AppLocalizations.of(context)!.translate;
    return Container(
      decoration: Constants.kGradientScaffoldDecoration,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            StatefulBuilder(
              builder: (context, setState) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: supportedLocals.length,
                  itemBuilder: (context, index) {
                    var supportedLocalsItem = supportedLocals[index];
                    bool isSelect = (supportedLocalsItem == locale);
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
                                  Constants.kLanguages[supportedLocalsItem] ?? '',
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(color: isSelect ? theme.secondaryHeaderColor : null),
                                ),
                                trailing:
                                    isSelect ? Icon(FontAwesomeIcons.check, color: theme.secondaryHeaderColor) : null,
                                onTap: () => setState(() {
                                  locale = supportedLocalsItem;
                                }),
                              ),
                            ),
                            (index == supportedLocals.length - 1)
                                ? const SizedBox()
                                : const Divider(height: 1, thickness: 0.5),
                          ],
                        ));
                  },
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomElevatedButton(
              onPressed: () {
                if (locale != currentLocale) {
                  context.read<SettingsCubit>().changeLanguage(locale);
                }
                Navigator.pop(context);
              },
              child: Text(
                translate('apply'),
                style: Styles.fontStyle16(context).copyWith(color: Theme.of(context).secondaryHeaderColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

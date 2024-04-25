import 'package:flutter/material.dart';
import 'package:hakawati/config/localization/localization.dart';
import 'package:hakawati/config/theme/theme.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)?.translate;
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const ToggleTheme(), Text(translate!('welcome') ?? ''), const ChangeLocal()],
        )),
      ),
    );
  }
}

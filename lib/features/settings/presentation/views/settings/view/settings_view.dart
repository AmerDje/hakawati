import 'package:flutter/material.dart';
import 'package:hakawati/core/utils/utils.dart';
import 'package:hakawati/core/widgets/gradient_scaffold.dart';
import 'package:hakawati/features/settings/presentation/views/settings/view/widgets/settings_view_body.dart';
import 'widgets/appbar_leading_button.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: const AppBarLeadingButton(),
        title: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Text(
            'Settings',
            style: Styles.fontStyle40(context),
          ),
        ),
      ),
      body: const SettingsViewBody(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hakawati/config/locale/locale.dart';
import 'package:hakawati/core/widgets/widgets.dart';
import 'package:hakawati/core/widgets/appbar_leading_button.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    super.key,
    this.onChanged,
  });
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!.translate;

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          const AppBarLeadingButton(),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: CustomTextField(
              icon: const Icon(Icons.search),
              hintText: translate("Search"),
              onChanged: onChanged,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}

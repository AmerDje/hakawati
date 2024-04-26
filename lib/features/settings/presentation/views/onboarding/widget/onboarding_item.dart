import 'package:flutter/material.dart';
import 'package:hakawati/config/locale/locale.dart';
import 'package:hakawati/core/utils/extensions/media_query.dart';
import 'package:hakawati/core/utils/styles.dart';
import 'package:hakawati/features/settings/data/entities/onboarding_entity.dart';

class OnboardingItem extends StatelessWidget {
  final OnboardingEntity onboardingEntity;
  const OnboardingItem({super.key, required this.onboardingEntity});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!.translate;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image(
          image: AssetImage(onboardingEntity.image),
          height: context.height * .7,
          width: context.width * .7,
        ),
        const SizedBox(
          height: 5.0,
        ),
        Text(translate(onboardingEntity.title) ?? '', style: Styles.fontStyle32(context)),
        const SizedBox(
          height: 15.0,
        ),
        Text(translate(onboardingEntity.description) ?? '',
            style: Styles.fontStyle16(context), textAlign: TextAlign.center),
      ],
    );
  }
}

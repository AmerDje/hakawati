import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakawati/config/locale/locale.dart';
import 'package:hakawati/core/utils/colors.dart';
import 'package:hakawati/core/utils/constants.dart';
import 'package:hakawati/core/utils/extensions/media_query.dart';
import 'package:hakawati/core/utils/styles.dart';
import 'package:hakawati/core/widgets/customs.dart';
import 'package:hakawati/features/settings/presentation/manager/settings_cubit.dart';
import 'package:hakawati/features/settings/presentation/views/onboarding/onboarding.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!.translate;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [HexColor('#12031F'), HexColor("#23103A")],
        )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: context.height * .85,
                  child: Stack(
                    children: [
                      PageView.builder(
                        physics: const BouncingScrollPhysics(),
                        controller: _pageController,
                        itemBuilder: (context, index) => OnboardingItem(onboardingEntity: kOnboardingData[index]),
                        itemCount: kOnboardingData.length,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Positioned(
                        top: context.height * .6,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _buildPageIndicator(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomElevatedButton(
                    fixedSize: Size(context.width * .9, 50),
                    onPressed: () {
                      context.read<SettingsCubit>().closeOnBoarding();
                    },
                    child: Text(
                      translate("get_started") ?? "Get Started",
                      style: Styles.fontStyle16(context).copyWith(color: Theme.of(context).secondaryHeaderColor),
                    )),
                CustomTextButton(
                  onPressed: () {
                    context.read<SettingsCubit>().closeOnBoarding();
                  },
                  btnText: translate("already_have_account") ?? "Already have an account?",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < kOnboardingData.length; i++) {
      indicators.add(
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: _currentPage == i ? 24 : 14,
          height: _currentPage == i ? 24 : 14,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: ShapeDecoration(
            shape: const OvalBorder(),
            color: _currentPage == i ? Colors.black.withOpacity(0.5) : AppColors.disabledItemColor,
          ),
          child: _currentPage == i
              ? Icon(Icons.dark_mode, color: Theme.of(context).secondaryHeaderColor)
              : const SizedBox(),
        ),
      );
    }
    return indicators;
  }
}

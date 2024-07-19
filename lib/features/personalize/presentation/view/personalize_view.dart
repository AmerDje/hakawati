import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakawati/core/utils/utils.dart';
import 'package:hakawati/core/widgets/widgets.dart';

import '../../../settings/presentation/views/settings/view/widgets/appbar_leading_button.dart';
import '../manager/personalize_cubit.dart';
import 'widgets/personalize_view_body.dart';

class PersonalizeView extends StatelessWidget {
  const PersonalizeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PersonalizeCubit(),
      child: GradientScaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          leading: const AppBarLeadingButton(),
          title: BlocBuilder<PersonalizeCubit, PersonalizeState>(
              buildWhen: (previous, current) => previous.pageIndex != current.pageIndex,
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(context, state.pageIndex),
                );
              }),
          centerTitle: true,
          actions: const [
            CustomTextButton(
              btnText: "Random",
              applyUnderLine: false,
            )
          ],
          backgroundColor: Colors.transparent,
        ),
        body: const PersonalizeViewBody(),
      ),
    );
  }

  List<Widget> _buildPageIndicator(BuildContext context, int currentPageIndex) {
    List<Widget> indicators = [];
    for (int i = 0; i < 4; i++) {
      bool isActive = currentPageIndex == i;
      bool formDone = currentPageIndex > i;
      indicators.add(
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: isActive ? 35 : 20,
          height: isActive ? 12 : 10,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: ShapeDecoration(
            shape: const StadiumBorder(),
            color: formDone || isActive ? Theme.of(context).secondaryHeaderColor : AppColors.disabledItemColor,
          ),
        ),
      );
    }
    return indicators;
  }
}

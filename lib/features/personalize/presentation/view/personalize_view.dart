import 'package:flutter/material.dart';
import 'package:hakawati/core/utils/utils.dart';
import 'package:hakawati/core/widgets/widgets.dart';
import 'package:hakawati/config/locale/locale.dart';
import 'package:hakawati/features/settings/presentation/views/settings/view/widgets/appbar_leading_button.dart';

class PersonalizeView extends StatefulWidget {
  const PersonalizeView({super.key});

  @override
  State<PersonalizeView> createState() => _PersonalizeViewState();
}

class _PersonalizeViewState extends State<PersonalizeView> {
  int _currentPage = 0;
  final List<FormModel> formScreens = [
    FormModel(formHeading: "formHeading", formOption: "formOption", form: const SizedBox()),
    FormModel(formHeading: "formHeading", formOption: "formOption", form: const SizedBox()),
    FormModel(formHeading: "formHeading", formOption: "formOption", form: const SizedBox())
  ];
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: AppBar(
        leading: const AppBarLeadingButton(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildPageIndicator(),
        ),
        centerTitle: true,
        actions: const [
          CustomTextButton(
            btnText: "Skip",
            applyUnderLine: false,
          )
        ],
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (value) => setState(() {
                  _currentPage = value;
                }),
                itemBuilder: (context, index) => FormWrapper(
                    formHeading: formScreens[index].formHeading,
                    formOption: formScreens[index].formOption,
                    form: formScreens[index].form),
                itemCount: formScreens.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < formScreens.length; i++) {
      bool isActive = _currentPage == i;
      indicators.add(
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: isActive ? 35 : 20,
          height: isActive ? 12 : 10,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: ShapeDecoration(
            shape: const StadiumBorder(),
            color: isActive ? Theme.of(context).secondaryHeaderColor : AppColors.disabledItemColor,
          ),
        ),
      );
    }
    return indicators;
  }
}

class FormWrapper extends StatefulWidget {
  const FormWrapper({
    super.key,
    required this.form,
    required this.formHeading,
    required this.formOption,
  });
  final String formHeading;
  final String formOption;
  final Widget form;

  @override
  State<FormWrapper> createState() => _FormWrapperState();
}

class _FormWrapperState extends State<FormWrapper> {
  Set<int> selectedIndexes = {};
  List nums = [1, 2, 3, 4, 5, 6, 7];
  bool isSelectMany = true;
  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!.translate;
    String text = 'This is a dynamic string with multiple colored words';
    Map<String, Color> coloredWords = {'dynamic': Theme.of(context).secondaryHeaderColor};

    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: Styles.getTextSpans(text, coloredWords, Styles.fontStyle32(context)),
          ),
        ),
        const Spacer(),
        Text(
          "Choose as many as you like",
          style: Styles.fontStyle22(context),
        ),
        const SizedBox(
          height: 15,
        ),
        Wrap(
          runSpacing: 15,
          spacing: 15,
          children: List.generate(
              nums.length,
              (index) => InkWell(
                  onTap: () {
                    if (isSelectMany) {
                      if (selectedIndexes.contains(index)) {
                        selectedIndexes.remove(index);
                      } else {
                        selectedIndexes.add(index);
                      }
                    } else {
                      selectedIndexes.clear();
                      selectedIndexes.add(index);
                    }
                    setState(() {});
                  },
                  child: CardsListItem(
                    nums: nums,
                    index: index,
                    isSelected: selectedIndexes.contains(index),
                  ))),
        ),
        const Spacer(),
        CustomElevatedButton(
            onPressed: () {},
            child: Text(
              translate("continue"),
              style: Styles.fontStyle16(context).copyWith(color: Theme.of(context).secondaryHeaderColor),
            )),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class CardsListItem extends StatelessWidget {
  const CardsListItem({super.key, required this.nums, required this.index, required this.isSelected});

  final List nums;
  final int index;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 60,
      width: (index == nums.length - 1 && index.isEven) ? context.width : (context.width * .5) - 30,
      decoration: ShapeDecoration(
          shape: StadiumBorder(
              side: isSelected ? BorderSide(width: 2, color: Theme.of(context).secondaryHeaderColor) : BorderSide.none),
          color: const Color(0xFF3D2F51)),
      child: Text(
        "data $index",
        style: Styles.fontStyle20(context).copyWith(color: isSelected ? Theme.of(context).secondaryHeaderColor : null),
      ),
    );
  }
}

class FormModel {
  final String formHeading;
  final String formOption;
  final Widget form;

  FormModel({
    required this.formHeading,
    required this.formOption,
    required this.form,
  });
}

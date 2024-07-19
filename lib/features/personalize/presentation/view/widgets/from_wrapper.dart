import 'package:flutter/material.dart';
import 'package:hakawati/config/locale/locale.dart';
import 'package:hakawati/core/utils/utils.dart';
import 'package:hakawati/core/widgets/widgets.dart';

import '../../../data/entities/form_entity.dart';
import 'cards_list_item.dart';

class FormWrapper extends StatelessWidget {
  const FormWrapper({
    super.key,
    required this.pageController,
    required this.formModel,
  });
  final PageController pageController;
  final FormModel formModel;
  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!.translate;

    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: RichText(
            text: TextSpan(
              children: Styles.getTextSpans(
                formModel.formQuestion,
                getMarkedWords(formModel.formQuestion, "@"),
                Styles.fontStyle36(context),
                Theme.of(context).secondaryHeaderColor,
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const Spacer(),
        Text(
          formModel.formHeading,
          style: Styles.fontStyle20(context),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 15,
        ),
        formModel.form,
        const Spacer(
          flex: 2,
        ),
        CustomElevatedButton(
            onPressed: () {
              if (formModel.formKey != null) {
                if (formModel.formKey!.currentState!.validate()) {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.bounceIn,
                  );
                }
              } else {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.bounceIn,
                );
              }
              if (pageController.page?.toInt() == 3) {
                context.go(const PersonalizationIndicator());
              }
            },
            child: Text(
              translate("continue"),
              style: Styles.fontStyle16(context).copyWith(
                color: Theme.of(context).secondaryHeaderColor,
              ),
            )),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class PersonalizationIndicator extends StatelessWidget {
  const PersonalizationIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Spacer(),
            //if story loaded with success
            if (5 == 6) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: RichText(
                  text: TextSpan(
                    children: Styles.getTextSpans(
                      "@Generating @Story in Progress.......",
                      ["@Generating", "@Story"],
                      Styles.fontStyle36(context),
                      Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                "0%",
                style: Styles.fontStyle54(context).copyWith(
                  color: Theme.of(context).secondaryHeaderColor,
                ),
              ),
              const Spacer(
                flex: 3,
              )
            ] else ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: RichText(
                  text: TextSpan(
                    children: Styles.getTextSpans(
                      "@Hooray!,  Story Generated @Successfully",
                      ["@Hooray!,", "@Successfully"],
                      Styles.fontStyle36(context),
                      Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              Text(
                "100%",
                style: Styles.fontStyle54(context).copyWith(
                  color: Theme.of(context).secondaryHeaderColor,
                ),
              ),
              const Spacer(
                flex: 3,
              ),
              CustomElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Go to Story",
                    style: Styles.fontStyle16(context).copyWith(color: Theme.of(context).secondaryHeaderColor),
                  )),
              const SizedBox(
                height: 20,
              ),
            ]
          ],
        ),
      ),
    );
  }
}

class CardsList extends StatefulWidget {
  const CardsList({
    super.key,
    required this.choices,
    required this.isSelectMany,
    this.cardsArrangementOnRow,
  });

  final List<String> choices;
  final bool isSelectMany;
  final bool? cardsArrangementOnRow;

  @override
  State<CardsList> createState() => _CardsListState();
}

class _CardsListState extends State<CardsList> {
  Set<int> selectedIndexes = {};

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 15,
      spacing: 15,
      children: List.generate(
          widget.choices.length,
          (index) => InkWell(
              onTap: () {
                if (widget.isSelectMany) {
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
                choice: widget.choices[index],
                isSelected: selectedIndexes.contains(index),
                //arranges two in one row, put true if you want to arrange only one
                cardsArrangementOnRow:
                    widget.cardsArrangementOnRow ?? (index == widget.choices.length - 1 && index.isEven),
              ))),
    );
  }
}

List<String> getMarkedWords(String text, String specialChar) {
  List<String> words = text.split(' ');
  List<String> markedWords = words.where((word) => word.startsWith(specialChar)).toList();
  return markedWords;
}

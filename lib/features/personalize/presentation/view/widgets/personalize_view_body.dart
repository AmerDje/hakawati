import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakawati/core/widgets/custom_text_field.dart';
import 'package:hakawati/features/personalize/data/entities/form_entity.dart';
import 'package:hakawati/features/personalize/presentation/manager/personalize_cubit.dart';

import '../../../../../core/utils/validators.dart';
import 'from_wrapper.dart';

class PersonalizeViewBody extends StatefulWidget {
  const PersonalizeViewBody({
    super.key,
  });

  @override
  State<PersonalizeViewBody> createState() => _PersonalizeViewBodyState();
}

class _PersonalizeViewBodyState extends State<PersonalizeViewBody> {
  late PageController _pageController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    final List<FormModel> formScreens = [
      FormModel(
        formQuestion: 'Hey there, my name is @Hakawati let\'s @generate a @Story together',
        formHeading: "Select the Way of generating",
        form: const CardsList(
          choices: ["Use Pervious Story Info", "Generate New Story"], isSelectMany: false,
          cardsArrangementOnRow: true, //arrange one on row,
        ),
      ),
      FormModel(
        formQuestion: 'What is the @Name of the @main @Character in your Story',
        formHeading: "Write the name down here",
        form: Form(
          key: _formKey,
          child: CustomTextField(
            hintText: 'Please put your name',
            onChanged: (value) {},
            validator: (value) {
              if (Validators.isNullOrEmpty(value)) {
                return "field is required";
              }
              return null;
            },
          ),
        ),
        formKey: _formKey,
      ),
      FormModel(
        formQuestion: 'What is the @Age @Range of that @Character',
        formHeading: "Choose only one range",
        form: const CardsList(
          choices: ["0-3 years", "4-6 years", "6-9 years", "9-12 years", "12+ years"],
          isSelectMany: false,
        ),
      ),
      FormModel(
        formQuestion: 'What is the @Genre of your @Story',
        formHeading: "Choose as many as you like",
        form: BlocBuilder<PersonalizeCubit, PersonalizeState>(
          builder: (context, state) {
            return const CardsList(
              choices: ["Fairy Tails", "Adventure", "Animals", "Space", "Educational", "Action", "Comedy"],
              isSelectMany: true,
            );
          },
        ),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                context.read<PersonalizeCubit>().changePage(index);
              },
              itemBuilder: (context, index) => FormWrapper(
                pageController: _pageController,
                formModel: formScreens[index],
              ),
              itemCount: formScreens.length,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

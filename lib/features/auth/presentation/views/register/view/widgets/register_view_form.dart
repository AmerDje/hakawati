import 'package:flutter/material.dart';
import 'package:hakawati/config/locale/locale.dart';
import 'package:hakawati/core/utils/utils.dart';
import 'package:hakawati/core/utils/validators.dart';
import 'package:hakawati/core/widgets/widgets.dart';
import 'package:hakawati/features/auth/presentation/views/widgets/auth_bottom.dart';
import 'package:hakawati/features/auth/presentation/views/widgets/auth_checkbox.dart';
import 'package:hakawati/features/auth/presentation/views/widgets/auth_divider.dart';
import 'package:hakawati/features/auth/presentation/views/widgets/privacy_conditions.dart';

class RegisterViewForm extends StatefulWidget {
  const RegisterViewForm({super.key});

  @override
  State<RegisterViewForm> createState() => _RegisterViewFormState();
}

class _RegisterViewFormState extends State<RegisterViewForm> {
  bool isTermAccepted = true;
  AutovalidateMode? _autovalidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email, password;
  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!.translate;
    return Form(
        key: _formKey,
        autovalidateMode: _autovalidateMode,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: Center(
                child: Text(
                  'Register',
                  style: Styles.fontStyle40(context),
                ),
              ),
            ),
            Text("Email", style: Styles.fontStyle16(context)),
            CustomTextField(
              hintText: 'Enter your email',
              onSaved: (value) {
                // email = value;
              },
              validator: (value) {
                if (Validators.isNullOrBlank(value)) {
                  return "Field can't empty";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            // Text("Phone number", style: Styles.fontStyle16(context)),
            // CustomTextField(
            //   hintText: 'Enter your phone number',
            //   onSaved: (value) {
            //     // email = value;
            //   },
            //   validator: (value) {
            //     if (Validators.isNullOrBlank(value)) {
            //       return "Field can't empty";
            //     }
            //     return null;
            //   },
            // ),
            // const SizedBox(
            //   height: 15,
            // ),
            Text("Password", style: Styles.fontStyle16(context)),
            CustomPasswordField(
              hintText: 'Enter your password',
              onSaved: (value) {
                // password = value;
              },
              validator: (value) {
                if (Validators.isNullOrBlank(value)) {
                  return "Field can't empty";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            AuthCheckbox(
              checkValue: isTermAccepted,
              onChanged: (value) {
                isTermAccepted = value!;
                isTermAccepted != isTermAccepted;
                setState(() {});
              },
              widget: const Expanded(child: PrivacyAndConditions()),
            ),
            const SizedBox(
              height: 15,
            ),
            const AuthDivider(),
            const SizedBox(
              height: 15,
            ),
            AuthBottom(
                text: 'Already have an account',
                onPressed: () {
                  Navigator.pop(context);
                },
                btnText: 'Login'),
            const SizedBox(
              height: 15,
            ),
            CustomElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                } else {
                  _autovalidateMode = AutovalidateMode.always;
                  setState(() {});
                }
              },
              child: Text(
                translate("register"),
                style: Styles.fontStyle16(context).copyWith(color: Theme.of(context).secondaryHeaderColor),
              ),
            ),
          ],
        ));
  }
}

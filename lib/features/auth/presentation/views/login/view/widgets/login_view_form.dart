import 'package:flutter/material.dart';
import 'package:hakawati/config/locale/locale.dart';
import 'package:hakawati/core/utils/extensions/navigator.dart';
import 'package:hakawati/core/utils/utils.dart';
import 'package:hakawati/core/utils/validators.dart';
import 'package:hakawati/core/widgets/widgets.dart';
import 'package:hakawati/features/auth/presentation/views/register/view/register_view.dart';
import 'package:hakawati/features/auth/presentation/views/widgets/auth_bottom.dart';
import 'package:hakawati/features/auth/presentation/views/widgets/auth_checkbox.dart';
import 'package:hakawati/features/auth/presentation/views/widgets/auth_divider.dart';

class LoginViewForm extends StatefulWidget {
  const LoginViewForm({super.key});

  @override
  State<LoginViewForm> createState() => _LoginViewFormState();
}

class _LoginViewFormState extends State<LoginViewForm> {
  bool isRemembered = false;
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
                  'Login',
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
              checkValue: isRemembered,
              onChanged: (value) {
                isRemembered = value!;
                isRemembered != isRemembered;
                setState(() {});
              },
              text: "Remember me",
              btnText: "Forgot password?",
              onPressed: () {},
            ),
            const SizedBox(
              height: 15,
            ),
            const AuthDivider(),
            const SizedBox(
              height: 15,
            ),
            AuthBottom(
                text: 'Don\'t have an account',
                btnText: 'Register',
                onPressed: () {
                  context.go(const RegisterView());
                }),
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
                translate("login"),
                style: Styles.fontStyle16(context).copyWith(color: Theme.of(context).secondaryHeaderColor),
              ),
            ),
          ],
        ));
  }
}

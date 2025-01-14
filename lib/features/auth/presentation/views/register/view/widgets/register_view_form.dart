import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakawati/config/locale/locale.dart';
import 'package:hakawati/core/utils/utils.dart';
import 'package:hakawati/core/utils/validators.dart';
import 'package:hakawati/core/widgets/widgets.dart';
import 'package:hakawati/features/auth/presentation/manager/auth_cubit.dart';
import 'package:hakawati/features/auth/presentation/views/register/manager/register_cubit.dart';
import 'package:hakawati/features/auth/presentation/views/register/view/widgets/email_verification_screen.dart';
import 'package:hakawati/features/auth/presentation/views/widgets/auth_bottom.dart';
import 'package:hakawati/features/auth/presentation/views/widgets/auth_checkbox.dart';
import 'package:hakawati/features/auth/presentation/views/widgets/auth_divider.dart';
import 'package:hakawati/features/auth/presentation/views/widgets/privacy_conditions.dart';
import 'package:hakawati/features/auth/presentation/views/widgets/social_sign_in.dart';
import 'package:hakawati/features/settings/presentation/manager/settings_cubit.dart';

class RegisterViewForm extends StatefulWidget {
  const RegisterViewForm({super.key});

  @override
  State<RegisterViewForm> createState() => _RegisterViewFormState();
}

class _RegisterViewFormState extends State<RegisterViewForm> {
  bool isTermAccepted = true;
  AutovalidateMode? _autovalidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email, password, phone, name;
  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!.translate;
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is VerificationEmailSent) {
          context.go(BlocProvider.value(
              value: context.read<RegisterCubit>(),
              child: EmailVerificationScreen(
                email: email ?? '',
              )));
        }
      },
      child: Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: SizedBox(
            height: context.height * .8,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: context.bottomInsets),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Register',
                      style: Styles.fontStyle40(context),
                    ),
                  ),
                  Text("Name", style: Styles.fontStyle16(context)),
                  CustomTextField(
                    hintText: 'Enter your name',
                    onSaved: (value) {
                      name = value;
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
                  Text("Email", style: Styles.fontStyle16(context)),
                  CustomTextField(
                    hintText: 'Enter your email',
                    onSaved: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (Validators.isNullOrBlank(value)) {
                        return "Field can't empty";
                      } else if (!Validators.isValidEmail(value)) {
                        return "Invalid email format";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text("Phone number", style: Styles.fontStyle16(context)),
                  CustomTextField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(13),
                      FilteringTextInputFormatter.digitsOnly,
                      NumberTextInputFormatter()
                    ],
                    hintText: '0666 ** ** **',
                    onSaved: (value) {
                      phone = value;
                    },
                    validator: (value) {
                      if (Validators.isNullOrBlank(value)) {
                        return "Field can't empty";
                      } else if (!Validators.isValidPhone(value)) {
                        return "Invalid phone format";
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
                      password = value;
                    },
                    validator: (value) {
                      if (Validators.isNullOrBlank(value)) {
                        return "Field can't empty";
                      } else if (value!.length < 6) {
                        return "Password must be at least 6 characters";
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
                  BlocConsumer<RegisterCubit, RegisterState>(
                    listener: (context, state) async {
                      if (state is RegisterSuccess) {
                        context.read<AuthCubit>().updateAuthStatus({
                          "user": state.user!.toJson(),
                          "token": state.user!.uid.toString(),
                        });
                        await context.read<RegisterCubit>().sendEmailVerification();
                      } else if (state is SignInWithFacebookSuccess || state is SignInWithGoogleSuccess) {
                        context.read<AuthCubit>().updateAuthStatus({
                          "user": state.user!.toJson(),
                          "token": state.user!.uid.toString(),
                        });
                      } else if (state is RegisterFailure ||
                          state is SignInWithFacebookFailure ||
                          state is SignInWithGoogleFailure) {
                        showSnackBar(context, state.errMessage!, isError: true);
                      }
                    },
                    builder: (context, state) {
                      return CustomElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            await context.read<RegisterCubit>().register(
                                email: email!.trim(),
                                name: name!.trim(),
                                phone: phone!.trim(),
                                password: password!,
                                locate: context.read<SettingsCubit>().state.locate);
                          } else {
                            _autovalidateMode = AutovalidateMode.always;
                            setState(() {});
                          }
                        },
                        child: state is RegisterLoading
                            ? const CupertinoActivityIndicator()
                            : Text(
                                translate("register"),
                                style:
                                    Styles.fontStyle16(context).copyWith(color: Theme.of(context).secondaryHeaderColor),
                              ),
                      );
                    },
                  ),
                  AuthBottom(
                      text: 'Already have an account',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      btnText: 'Login'),
                  const AuthDivider(),
                  const SizedBox(
                    height: 15,
                  ),
                  SocialSignInButtons(cubit: context.read<RegisterCubit>()),
                ],
              ),
            ),
          )),
    );
  }
}

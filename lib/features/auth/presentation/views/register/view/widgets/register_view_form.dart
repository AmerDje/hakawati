import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakawati/config/locale/locale.dart';
import 'package:hakawati/core/utils/utils.dart';
import 'package:hakawati/core/utils/validators.dart';
import 'package:hakawati/core/widgets/widgets.dart';
import 'package:hakawati/features/auth/data/models/user.dart';
import 'package:hakawati/features/auth/presentation/manager/auth_cubit.dart';
import 'package:hakawati/features/auth/presentation/views/login/view/login_view.dart';
import 'package:hakawati/features/auth/presentation/views/register/manager/register_cubit.dart';
import 'package:hakawati/features/auth/presentation/views/widgets/auth_bottom.dart';
import 'package:hakawati/features/auth/presentation/views/widgets/auth_checkbox.dart';
import 'package:hakawati/features/auth/presentation/views/widgets/auth_divider.dart';
import 'package:hakawati/features/auth/presentation/views/widgets/privacy_conditions.dart';
import 'package:hakawati/features/home/presentation/home.dart';
import 'package:hakawati/features/settings/presentation/manager/settings_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                hintText: '0664 123 456',
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
              BlocConsumer<RegisterCubit, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterSuccess) {
                    context.read<AuthCubit>().updateAuthStatus({
                      "user": state.user.toJson(),
                      "token": state.user.uid.toString(),
                    });
                    context.read<RegisterCubit>().sendEmailVerification();
                  } else if (state is RegisterFailure) {
                    showSnackBar(context, state.errMessage, isError: true);
                  }
                },
                builder: (context, state) {
                  return CustomElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        await context.read<RegisterCubit>().register(
                            email: email!,
                            name: name!,
                            phone: phone!,
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
                            style: Styles.fontStyle16(context).copyWith(color: Theme.of(context).secondaryHeaderColor),
                          ),
                  );
                },
              ),
            ],
          )),
    );
  }
}

class EmailVerificationScreen extends StatelessWidget {
  final String email;
  const EmailVerificationScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocListener<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is VerificationSuccess) {
                UserModel oldUser = context.read<AuthCubit>().state.user;
                UserModel newUser = oldUser.copyWith(emailVerified: true);
                context.read<RegisterCubit>().updateUser(newUser);
                context.read<AuthCubit>().updateAuthStatus({
                  "user": newUser.toJson(),
                  "token": newUser.uid.toString(),
                });
                context.go(const HomeView());
              }
              if (state is DeleteUserSuccess) {
                context.read<AuthCubit>().updateAuthStatus({
                  "user": UserModel.empty,
                  "token": null,
                });
                context.go(const LoginView());
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'We have sent you an email verification link to $email. Please check your email and click on the link to verify your email address.',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 16),
                const Text(
                  'If you haven\'t received the email, please check your spam folder or click the button below to resend the email.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 32),
                Center(
                  child: Column(
                    children: [
                      CustomElevatedButton(
                        onPressed: () async {
                          final Uri emailLaunchUrl = Uri(
                            scheme: 'mailto',
                            path: email,
                          );
                          try {
                            launchUrl(emailLaunchUrl);
                          } catch (e) {
                            debugPrint(e.toString());
                          }
                        },
                        child: Text(
                          'Check Email Verification',
                          style: Styles.fontStyle16(context).copyWith(color: Theme.of(context).secondaryHeaderColor),
                        ),
                      ),
                      CustomTextButton(
                        onPressed: () {
                          context.read<RegisterCubit>().sendEmailVerification();
                        },
                        btnText: 'Resend Email Verification',
                      ),
                      CustomTextButton(
                        onPressed: () {
                          context.read<RegisterCubit>().deleteUser();
                        },
                        btnText: 'Delete My Account',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

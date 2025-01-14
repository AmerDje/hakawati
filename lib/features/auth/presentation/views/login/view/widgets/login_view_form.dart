import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakawati/config/locale/locale.dart';
import 'package:hakawati/core/utils/utils.dart';
import 'package:hakawati/core/utils/validators.dart';
import 'package:hakawati/core/widgets/widgets.dart';
import 'package:hakawati/features/auth/presentation/manager/auth_cubit.dart';
import 'package:hakawati/features/auth/presentation/views/login/manager/login_cubit.dart';
import 'package:hakawati/features/auth/presentation/views/register/view/register_view.dart';
import 'package:hakawati/features/auth/presentation/views/widgets/auth_bottom.dart';
import 'package:hakawati/features/auth/presentation/views/widgets/auth_checkbox.dart';
import 'package:hakawati/features/auth/presentation/views/widgets/auth_divider.dart';
import 'package:hakawati/features/auth/presentation/views/widgets/social_sign_in.dart';
import 'package:hakawati/features/bottom_navbar/presentation/view/bottom_navbar_view.dart';

class LoginViewForm extends StatefulWidget {
  const LoginViewForm({super.key});

  @override
  State<LoginViewForm> createState() => _LoginViewFormState();
}

class _LoginViewFormState extends State<LoginViewForm> {
  bool isRemembered = true;
  AutovalidateMode? _autovalidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email, password;
  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!.translate;
    return Form(
        key: _formKey,
        autovalidateMode: _autovalidateMode,
        child: SizedBox(
          height: context.height * .65,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: context.bottomInsets),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Login',
                    style: Styles.fontStyle40(context),
                  ),
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
                Text("Password", style: Styles.fontStyle16(context)),
                CustomPasswordField(
                  hintText: 'Enter your password',
                  onSaved: (value) {
                    password = value;
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
                StatefulBuilder(builder: (context, customSetState) {
                  return AuthCheckbox(
                    checkValue: isRemembered,
                    onChanged: (value) {
                      isRemembered = value!;
                      isRemembered != isRemembered;
                      customSetState(() {});
                    },
                    text: "Remember me",
                    btnText: "Forgot password?",
                    onPressed: () {},
                  );
                }),
                const SizedBox(
                  height: 15,
                ),
                BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccess ||
                        state is SignInWithFacebookSuccess ||
                        state is SignInWithGoogleSuccess) {
                      if (isRemembered) {
                        context.read<AuthCubit>().updateAuthStatus({
                          "user": state.user!.toJson(),
                          "token": state.user!.uid.toString(),
                        });
                      } else {
                        context.read<AuthCubit>().updateAuthStatus({
                          "user": state.user!.toJson(),
                          "token": state.user!.uid.toString(),
                          "isRemembered": false,
                        });
                      }
                      context.go(const BottomNavbarView());
                    } else if (state is LoginFailure ||
                        state is SignInWithFacebookFailure ||
                        state is SignInWithGoogleFailure) {
                      showSnackBar(context, state.errMessage!, isError: true);
                    }
                  },
                  builder: (context, state) {
                    return CustomElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          context.read<LoginCubit>().login(email!.trim(), password!);
                        } else {
                          _autovalidateMode = AutovalidateMode.always;
                          setState(() {});
                        }
                      },
                      child: state is LoginLoading
                          ? const CupertinoActivityIndicator()
                          : Text(
                              translate("login"),
                              style:
                                  Styles.fontStyle16(context).copyWith(color: Theme.of(context).secondaryHeaderColor),
                            ),
                    );
                  },
                ),
                AuthBottom(
                    text: 'Don\'t have an account',
                    btnText: 'Register',
                    onPressed: () {
                      context.go(const RegisterView());
                    }),
                const SizedBox(
                  height: 5,
                ),
                const AuthDivider(),
                const SizedBox(
                  height: 15,
                ),
                SocialSignInButtons(cubit: context.read<LoginCubit>()),
              ],
            ),
          ),
        ));
  }
}

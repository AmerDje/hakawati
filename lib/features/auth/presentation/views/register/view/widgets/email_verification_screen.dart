import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakawati/core/utils/utils.dart';
import 'package:hakawati/core/widgets/widgets.dart';
import 'package:hakawati/features/auth/data/models/user.dart';
import 'package:hakawati/features/auth/presentation/manager/auth_cubit.dart';
import 'package:hakawati/features/auth/presentation/views/login/view/login_view.dart';
import 'package:hakawati/features/auth/presentation/views/register/manager/register_cubit.dart';
import 'package:hakawati/features/bottom_navbar/presentation/view/bottom_navbar_view.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailVerificationScreen extends StatelessWidget {
  final String email;
  final String password;
  const EmailVerificationScreen({super.key, required this.email, required this.password});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (_, __) async {
          await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text("Are you sure you want to exit?"),
              content: const Text("By exiting you will be logged out and will have to register again"),
              actions: [
                CustomTextButton(
                  applyUnderLine: false,
                  onPressed: () {
                    _deleteAccountAndExit(context);
                  },
                  btnText: 'Yes',
                ),
                CustomTextButton(
                  applyUnderLine: false,
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  btnText: 'No',
                )
              ],
            ),
          );
        },
        child: Center(
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
                  context.go(const BottomNavbarView());
                }
                if (state is DeleteUserSuccess) {
                  context.read<AuthCubit>().updateAuthStatus({
                    "user": const UserModel(),
                    "token": null,
                  });
                  context.go(const LoginView());
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text.rich(
                      style: const TextStyle(fontSize: 18),
                      TextSpan(text: "We have sent you an email verification link to ", children: [
                        TextSpan(
                            text: email,
                            style:
                                TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).secondaryHeaderColor)),
                        const TextSpan(
                            text: " Please check your email and click on the link to verify your email address.")
                      ])),
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
                            showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                        title: const Text('Are you sure you want to delete your account?'),
                                        actions: [
                                          CustomTextButton(
                                            applyUnderLine: false,
                                            onPressed: () {
                                              _deleteAccountAndExit(context);
                                            },
                                            btnText: 'Yes',
                                          ),
                                          CustomTextButton(
                                            applyUnderLine: false,
                                            onPressed: () {
                                              Navigator.pop(ctx);
                                            },
                                            btnText: 'No',
                                          )
                                        ]));
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
      ),
    );
  }

  void _deleteAccountAndExit(BuildContext context) async {
    await context.read<RegisterCubit>().temporaryLogin(email, password);
    if (context.mounted) context.read<RegisterCubit>().deleteUser();
  }
}

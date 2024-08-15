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
  const EmailVerificationScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
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
                context.go(const BottomNavbarView());
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
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                      title: const Text('Are you sure you want to delete your account?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            context.read<RegisterCubit>().deleteUser();
                                          },
                                          child: const Text('Yes'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('No'),
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
    );
  }
}

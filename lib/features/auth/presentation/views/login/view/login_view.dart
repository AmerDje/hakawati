import 'package:flutter/material.dart';
import 'package:hakawati/features/auth/presentation/views/login/view/widgets/login_view_form.dart';
import 'package:hakawati/features/auth/presentation/views/widgets/auth_header.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  static const routeName = '/login';
  @override
  Widget build(BuildContext context) {
    return const AuthHeader(child: LoginViewForm());
  }
}

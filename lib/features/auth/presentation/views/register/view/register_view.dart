import 'package:flutter/material.dart';
import 'package:hakawati/features/auth/presentation/views/register/view/widgets/register_view_form.dart';
import 'package:hakawati/features/auth/presentation/views/widgets/auth_header.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});
  static const routeName = '/register';
  @override
  Widget build(BuildContext context) {
    return const AuthHeader(child: RegisterViewForm());
  }
}

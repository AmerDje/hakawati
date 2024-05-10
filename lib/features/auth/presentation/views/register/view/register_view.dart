import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakawati/core/service/service_locator.dart';
import 'package:hakawati/features/auth/presentation/views/register/manager/register_cubit.dart';
import 'package:hakawati/features/auth/presentation/views/register/view/widgets/register_view_form.dart';
import 'package:hakawati/features/auth/presentation/views/widgets/auth_header.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});
  static const routeName = '/register';
  @override
  Widget build(BuildContext context) {
    return AuthHeader(
        child: BlocProvider(
      child: const RegisterViewForm(),
      create: (context) => sl.get<RegisterCubit>(),
    ));
  }
}

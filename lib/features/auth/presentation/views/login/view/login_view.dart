import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakawati/core/services/service_locator.dart';
import 'package:hakawati/features/auth/data/repository/auth_repository_impl.dart';
import 'package:hakawati/features/auth/presentation/views/login/manager/login_cubit.dart';
import 'package:hakawati/features/auth/presentation/views/login/view/widgets/login_view_form.dart';
import 'package:hakawati/features/auth/presentation/views/widgets/auth_header.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  static const routeName = '/login';
  @override
  Widget build(BuildContext context) {
    return AuthHeader(
        child: BlocProvider(
      child: const LoginViewForm(),
      create: (context) => LoginCubit(sl.get<AuthRepositoryImpl>()),
    ));
  }
}

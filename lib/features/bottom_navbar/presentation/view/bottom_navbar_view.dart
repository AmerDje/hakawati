import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakawati/features/bottom_navbar/presentation/view/widgets/bottom_navbar_body.dart';
import 'package:hakawati/features/bottom_navbar/presentation/manager/bottom_navigation_cubit.dart';

class BottomNavbarView extends StatelessWidget {
  const BottomNavbarView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavigationCubit(),
      child: const BottomNavbarBody(),
    );
  }
}

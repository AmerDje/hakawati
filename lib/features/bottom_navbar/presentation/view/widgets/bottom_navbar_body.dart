import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hakawati/core/utils/styles.dart';
import 'package:hakawati/core/widgets/widgets.dart';
import 'package:hakawati/features/bottom_navbar/data/navbar_entity.dart';
import 'package:hakawati/features/home/presentation/home.dart';
import 'package:hakawati/features/bottom_navbar/presentation/manager/bottom_navigation_cubit.dart';

class BottomNavbarBody extends StatefulWidget {
  const BottomNavbarBody({
    super.key,
  });

  @override
  State<BottomNavbarBody> createState() => _BottomNavbarBodyState();
}

class _BottomNavbarBodyState extends State<BottomNavbarBody> {
  final List<NavbarEntity> widgets = [
    NavbarEntity(
      filledIcon: FontAwesomeIcons.tent,
      // outlinedIcon: Icons.home_outlined,
      title: "Home",
      page: const HomeView(),
    ),
    NavbarEntity(
      filledIcon: FontAwesomeIcons.book,
      // outlinedIcon: Icons.settings_outlined,
      title: "Settings",
      page: const HomeView(),
    ),
    NavbarEntity(
      filledIcon: FontAwesomeIcons.hatWizard,
      // outlinedIcon: Icons.account_box_outlined,
      title: "Profile",
      page: const HomeView(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(child: widgets[state].page),
          bottomNavigationBar: SafeArea(
            minimum: const EdgeInsets.all(12),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 35),
              height: 80,
              child: GlassFilter(
                borderRadius: const BorderRadius.all(Radius.circular(45)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(widgets.length, (index) {
                      final isActive = (state == index);
                      return InkWell(
                        radius: 20,
                        splashFactory: NoSplash.splashFactory,
                        borderRadius: const BorderRadius.all(Radius.circular(24)),
                        onTap: () {
                          context.read<BottomNavigationCubit>().changeIndex(index);
                        },
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FittedBox(
                                child: SizedBox(
                                    height: 30,
                                    width: 50,
                                    child: Opacity(
                                      opacity: isActive ? 1 : 0.5,
                                      child: Icon(
                                        // isActive ?
                                        widgets[index].filledIcon, // : widgets[index].outlinedIcon,
                                        size: 30,
                                      ),
                                    )),
                              ),
                              const SizedBox(height: 3),
                              Text(widgets[index].title,
                                  style: Styles.fontStyle10(context).copyWith(
                                      fontWeight: isActive ? FontWeight.bold : FontWeight.w300,
                                      color: isActive ? Theme.of(context).secondaryHeaderColor : null)),
                              //  AnimatedBar(isActive: isActive),
                            ]),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

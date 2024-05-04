import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  animateTo(Widget widget, {RouteSettings? settings}) {
    Navigator.push(this, PageTransitionAnimation(widget: widget, arguments: settings));
  }

  go(Widget widget, {RouteSettings? settings}) {
    Navigator.push(this, MaterialPageRoute(builder: (_) => widget, settings: settings));
  }
}

class PageTransitionAnimation extends PageRouteBuilder {
  final Widget widget;
  final RouteSettings? arguments;
  PageTransitionAnimation({this.arguments, required this.widget})
      : super(
            settings: arguments,
            transitionDuration: const Duration(milliseconds: 300),
            pageBuilder: (context, animation, secondaryAnimation) => widget,
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              animation = CurvedAnimation(parent: animation, curve: Curves.easeIn);
              return ScaleTransition(
                alignment: Alignment.center,
                scale: animation,
                child: child,
              );
            });
}

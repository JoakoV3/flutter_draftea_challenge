import 'package:flutter/material.dart';

class ScreenLayout extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;

  const ScreenLayout({super.key, required this.mobile, required this.desktop});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return constraints.maxWidth <= 600 ? mobile : desktop;
      },
    );
  }
}

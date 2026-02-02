import 'package:flutter/material.dart';
import 'package:flutter_draftea_challenge/core/responsive/screen_layout.dart';
import 'package:flutter_draftea_challenge/features/pokedex/presentation/pages/home/home_desktop_page.dart';
import 'package:flutter_draftea_challenge/features/pokedex/presentation/pages/home/home_mobile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenLayout(
      mobile: HomeMobilePage(),
      desktop: HomeDesktopPage(),
    );
  }
}

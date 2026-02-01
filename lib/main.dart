import 'package:flutter/material.dart';
import 'package:flutter_draftea_challenge/router/app_router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'Draftea Pokedex Challenge',
      debugShowCheckedModeBanner: false,
    );
  }
}

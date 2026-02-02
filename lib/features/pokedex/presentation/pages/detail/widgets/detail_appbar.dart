import 'package:flutter/material.dart';
import 'package:flutter_draftea_challenge/core/theme/app_colors.dart';

class DetailAppbar extends AppBar {
  DetailAppbar({super.key})
    : super(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.pokemonRed, AppColors.pokemonRedDark],
              stops: [0.2, 0.8],
            ),
          ),
        ),
      );
}

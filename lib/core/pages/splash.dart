import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home_main/prensentation/pages/home_main.dart';
import '../../resource/app_colors.dart';
import '../blocs/app_bloc.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
        listener: (context, state) {
          if (state is AppStateUnAuthenticated) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeMainPage()),
              (route) => false,
            );
          } else if (state is AppStateAuthenticated) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeMainPage()),
              (route) => false,
            );
          }
        },
        child: const ColoredBox(
          color: AppColors.backgroundColor,
        ));
  }
}

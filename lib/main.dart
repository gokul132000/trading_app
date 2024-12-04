import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/blocs/app_bloc.dart';
import 'core/pages/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    BlocProvider(
      create: (context) => AppBloc()
        ..add(
          const AppEventFetchUserData(),
        ),
      child: const MyApp(),
    ),
  );
}

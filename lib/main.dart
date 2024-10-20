import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/core/configs/theme/app_theme.dart';

import 'features/splash/presentation/blocs/splash_cubit.dart';
import 'features/splash/presentation/pages/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..appStarted(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: AppTheme.appTheme,
          debugShowCheckedModeBanner: false,
          home: const SplashPage()
      ),
    );
  }
}

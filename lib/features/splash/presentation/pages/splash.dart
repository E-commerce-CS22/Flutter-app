import 'package:smartstore/core/configs/assets/app_vectors.dart';
import 'package:smartstore/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartstore/features/home/presentation/pages/home.dart';
import '../../../../common/bloc/auth/auth_state.dart';
import '../../../../common/bloc/auth/auth_state_cubit.dart';
import '../../../authentication/presentation/pages/welcome_page.dart';
// import '../blocs/splash_cubit.dart';
// import '../blocs/splash_state.dart';
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthStateCubit()..appStarted(),
      child: Scaffold(
        body: BlocBuilder<AuthStateCubit, AuthState>(
          builder: (context, state) {
            // Handle different states
            if (state is Authenticated) {
              // Navigate to the home screen
              return const HomePage();
            } else if (state is UnAuthenticated) {
              // Navigate to the login screen
              return WelcomePage();
            }
            // Show the splash screen while checking the state
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.gradient1, AppColors.gradient2],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: SvgPicture.asset(AppVectors.appLogo),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:smartstore/common/helper/navigator/app_navigator.dart';
import 'package:smartstore/core/configs/assets/app_vectors.dart';
import 'package:smartstore/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../authentication/presentation/pages/welcome_page.dart';
import '../blocs/splash_cubit.dart';
import '../blocs/splash_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit,SplashState>(
      listener: (context, state) {
        if(state is UnAuthenticated){
          AppNavigator.pushReplacement(context, WelcomePage());
        }
        if(state is Authenticated) {
          AppNavigator.pushReplacement(context, WelcomePage());
        }
      },
      child: Scaffold(
        // backgroundColor: AppColors.primary,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.gradient1, AppColors.gradient2],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: SvgPicture.asset(
                AppVectors.appLogo
            ),
          ),
        ),
      ),
    );
  }
}
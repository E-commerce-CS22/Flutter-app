import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/features/splash/presentation/blocs/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {

  SplashCubit() : super(DisplaySplash());

  void appStarted() async {
    await Future.delayed(const Duration(seconds: 2));

    // Custom logic to determine authentication status
    // For now, let's assume the user is authenticated
    bool isLoggedIn = true; // or false, based on your condition

    if (isLoggedIn) {
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }
}

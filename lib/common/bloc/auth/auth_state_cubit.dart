import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../features/authentication/domain/usecases/is_logged_in.dart';
import '../../../features/authentication/domain/usecases/logout.dart';
import '../../../service_locator.dart';
import 'auth_state.dart';

class AuthStateCubit extends Cubit<AuthState> {
  AuthStateCubit() : super(AppInitialState());

  void appStarted() async {
    var isLoggedIn = await sl<IsLoggedInUseCase>().call();
    if (isLoggedIn) {
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }

  void login() {
    emit(Authenticated());
  }

  Future<void> logout() async {
    try {
      emit(AuthLoading());
      // استدعاء الـ LogoutUseCase بشكل صحيح
      var result = await sl<LogoutUseCase>().call();
      result.fold(
            (failure) {
          // في حال حدوث خطأ أثناء الـ logout
          emit(AuthError("حدث خطأ أثناء تسجيل الخروج"));
        },
            (success) {
          // إذا تم تسجيل الخروج بنجاح
          emit(UnAuthenticated());
          print('تم تسجيل الخروج بنجاح');
          },
      );
    } catch (e) {
      emit(AuthError("حدث خطأ غير متوقع"));
    }
  }

  Future<void> checkSessionStatus() async {
    // تحقق من حالة الجلسة (هل المستخدم مسجل دخول أم لا)
    var isLoggedIn = await sl<IsLoggedInUseCase>().call();
    if (isLoggedIn) {
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }
}

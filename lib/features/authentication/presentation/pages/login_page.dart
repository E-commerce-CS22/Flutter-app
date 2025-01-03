import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/common/bloc/button/button_state.dart';
import 'package:smartstore/common/bloc/button/button_state_cubit.dart';
import 'package:smartstore/common/widgets/appbar/app_bar.dart';
import 'package:smartstore/features/authentication/data/models/signin_req_params.dart';
import 'package:smartstore/features/authentication/domain/usecases/signin.dart';
import 'package:smartstore/features/authentication/presentation/pages/signup_page.dart';
import '../../../../common/helper/navigator/app_navigator.dart';
import '../../../../common/widgets/button/basic_app_button.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../../../../core/configs/theme/app_theme.dart';
import '../../../../service_locator.dart';
import '../../../home/presentation/pages/home.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CurvedAppBar(
          title: Text("تسجيل الدخول"),
          hideBack: true,
        ),
        body: BlocProvider(
          create: (context) => ButtonStateCubit(),
          child: BlocListener<ButtonStateCubit, ButtonState>(
            listener: (context, state) {
              if (state is ButtonSuccessState) {
                AppNavigator.pushReplacement(context, HomePage());
              }
              if (state is ButtonFailureState) {
                var snackBar = SnackBar(content: Text(state.errorMessage));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _welcomeMessage(context),
                    const SizedBox(height: 5),
                    _description(context),
                    const SizedBox(height: 30),
                    _emailField(context),
                    const SizedBox(height: 20),
                    _passwordField(context),
                    const SizedBox(
                      height: 20,
                    ),
                    _continueButton(context),
                    const SizedBox(
                      height: 10,
                    ),
                    _createAccount(context),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget _welcomeMessage(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Directionality(
        textDirection: TextDirection.rtl,
        child: Text(
          'مرحباً بعودتك ...',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }

  Widget _description(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Directionality(
        textDirection: TextDirection.rtl,
        child: Text(
          'ادخل البيانات المطلوبة لتسجيل الدخول',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Set the direction to RTL for Arabic
      child: TextField(
        controller: _emailCon,
        textAlign: TextAlign.right, // Align text to the right
        decoration: const InputDecoration(
          hintText: 'البريد الإلكتروني',
          alignLabelWithHint: true, // Align the hint text properly in RTL
        ),
      ),
    );
  }

  Widget _passwordField(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Set the direction to RTL for Arabic
      child: TextField(
        controller: _passwordCon,
        textAlign: TextAlign.right,
        // Align text to the right
        obscureText: true,
        // Hide the input text (important for passwords)
        decoration: const InputDecoration(
          hintText: 'كلمة السر',
          alignLabelWithHint: true, // Align the hint text properly in RTL
        ),
        keyboardType: TextInputType.visiblePassword,
        // Use the proper keyboard type for passwords
        textInputAction: TextInputAction.done, // 'Done' action on keyboard
      ),
    );
  }

  Widget _continueButton(BuildContext context) {
    return Builder(builder: (context) {
      return BasicAppButton(
          onPressed: () {
            context.read<ButtonStateCubit>().execute(
                usecase: sl<SigninUseCase>(),
                params: SigninReqParams(
                    email: _emailCon.text,
                    password: _passwordCon.text,
                )
            );

            // AppNavigator.push();
          },
          title: 'تسجيل الدخول');
    });
  }

  Widget _createAccount(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Set the direction to RTL for Arabic
      child: Center(
        child: RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: "ليس لديك حساب؟ ",
                // Arabic text for "Don't you have an account?"
                style: AppTheme.blackTextStyle,
              ),
              TextSpan(
                text: 'إنشاء حساب', // Arabic text for "Create one"
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    AppNavigator.push(context, SignupPage());
                  },
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Almarai',
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

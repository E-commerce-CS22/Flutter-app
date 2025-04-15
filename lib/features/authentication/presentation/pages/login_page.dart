import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/common/bloc/button/button_state.dart';
import 'package:smartstore/common/bloc/button/button_state_cubit.dart';
import 'package:smartstore/common/widgets/appbar/app_bar.dart';
import 'package:smartstore/features/authentication/data/models/signin_req_params.dart';
import 'package:smartstore/features/authentication/domain/usecases/signin.dart';
import 'package:smartstore/features/authentication/presentation/pages/signup_page.dart';
import '../../../../common/bloc/auth/auth_state_cubit.dart';
import '../../../../common/helper/navigator/app_navigator.dart';
import '../../../../common/widgets/button/basic_app_button.dart';
import '../../../../common/widgets/button/basic_reactive_button.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../../../../core/configs/theme/app_theme.dart';
import '../../../../service_locator.dart';
import '../../../home/presentation/pages/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailCon = TextEditingController();
  final _passwordCon = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailCon.text = "hazim@gmail.com";       // تعيين القيمة الابتدائية
    _passwordCon.text = "password123";        // تعيين كلمة المرور مبدئياً
  }

  @override
  void dispose() {
    _emailCon.dispose();
    _passwordCon.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CurvedAppBar(
        title: Text("تسجيل الدخول"),
        hideBack: true,
        height: 135,
      ),
      body: BlocProvider(
        create: (context) => ButtonStateCubit(),
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonSuccessState) {
              context.read<AuthStateCubit>().appStarted();
              AppNavigator.pushReplacement(context, HomePage());
            }
            if (state is ButtonFailureState) {
              var snackBar = SnackBar(content: Text(state.errorMessage));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Form(
                  key: _formKey,
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
                      const SizedBox(height: 20),
                      _continueButton(context),
                      const SizedBox(height: 10),
                      _createAccount(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: _emailCon,
        textAlign: TextAlign.right,
        focusNode: _emailFocusNode,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          labelText: 'البريد الإلكتروني',
          alignLabelWithHint: true,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'البريد الإلكتروني لا يمكن أن يكون فارغاً';
          }
          final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
          if (!emailRegExp.hasMatch(value)) {
            return 'يرجى إدخال بريد إلكتروني صحيح';
          }
          return null;
        },
      ),
    );
  }

  Widget _passwordField(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: _passwordCon,
        textAlign: TextAlign.right,
        focusNode: _passwordFocusNode,
        obscureText: true,
        decoration: const InputDecoration(
          labelText: 'كلمة السر',
          alignLabelWithHint: true,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'كلمة السر لا يمكن أن تكون فارغة';
          }
          if (value.length < 6) {
            return 'يجب أن تكون كلمة السر 6 أحرف على الأقل';
          }
          return null;
        },
      ),
    );
  }

  Widget _continueButton(BuildContext context) {
    return Builder(builder: (context) {
      return BasicReactiveButton(
        onPressed: () {
          FocusScope.of(context).requestFocus(FocusNode());

          if (_formKey.currentState?.validate() ?? false) {
            String email = _emailCon.text.trim();
            String password = _passwordCon.text.trim();

            context.read<ButtonStateCubit>().execute(
              usecase: sl<SigninUseCase>(),
              params: SigninReqParams(
                email: email,
                password: password,
              ),
            );
          } else {
            print("Validation failed");
          }
        },
        title: 'تسجيل الدخول',
      );
    });
  }

  Widget _createAccount(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: "ليس لديك حساب؟ ",
                style: AppTheme.blackTextStyle,
              ),
              TextSpan(
                text: 'إنشاء حساب',
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

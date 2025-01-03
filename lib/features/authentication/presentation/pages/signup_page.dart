import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/common/bloc/button/button_state.dart';
import 'package:smartstore/common/bloc/button/button_state_cubit.dart';
import 'package:smartstore/common/widgets/appbar/app_bar.dart';
import 'package:smartstore/common/widgets/button/basic_reactive_button.dart';
import 'package:smartstore/core/configs/theme/app_colors.dart';
import 'package:smartstore/features/authentication/data/models/signup_req_Params.dart';
import 'package:smartstore/features/authentication/domain/usecases/signup.dart';
import '../../../../common/helper/navigator/app_navigator.dart';
import '../../../../core/configs/theme/app_theme.dart';
import '../../../../service_locator.dart';
import '../../../home/presentation/pages/home.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController _firstNameCon = TextEditingController();
  final TextEditingController _lastNameCon = TextEditingController();
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _phoneCon = TextEditingController();
  final TextEditingController _usernameCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();
  final TextEditingController _confirmPasswordCon = TextEditingController();
  final TextEditingController _addressCon = TextEditingController();
  final TextEditingController _cityCon = TextEditingController();
  final TextEditingController _postalCodeCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CurvedAppBar(
        title: Text("إنشاء حساب"),
        hideBack: true,
      ),
      body: BlocProvider(
        create: (context) => ButtonStateCubit(),
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if(state is ButtonSuccessState){
              AppNavigator.pushReplacement(context, HomePage());

            }
            if(state is ButtonFailureState){
              var snackBar = SnackBar(content: Text(state.errorMessage));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _welcomeMessage(context),
                    const SizedBox(height: 5),
                    _description(context),
                    const SizedBox(height: 30),
                    _firstName(context),
                    const SizedBox(height: 15),
                    _lastName(context),
                    const SizedBox(height: 15),
                    _emailField(context),
                    const SizedBox(height: 15),
                    _phone(context),
                    const SizedBox(height: 15),
                    _username(context),
                    const SizedBox(height: 15),
                    _passwordField(context),
                    const SizedBox(height: 15),
                    _confirmPasswordField(context),
                    const SizedBox(height: 15),
                    _address(context),
                    const SizedBox(height: 15),
                    _city(context),
                    const SizedBox(height: 15),
                    _postalCode(context),
                    const SizedBox(height: 15),
                    _signupButton(context),
                    const SizedBox(height: 15),
                    _loginInstead(context),
                  ],
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
          'مرحباً بك!',
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
          'أدخل المعلومات لإنشاء حساب جديد',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }

  Widget _firstName(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        controller: _firstNameCon,
        textAlign: TextAlign.right,
        decoration: const InputDecoration(
          labelText: 'الاسم الأول',
          alignLabelWithHint: true,
        ),
      ),
    );
  }


  Widget _lastName(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        controller: _lastNameCon,
        textAlign: TextAlign.right,
        decoration: const InputDecoration(
          labelText: 'الاسم الأخير',
          alignLabelWithHint: true,
        ),
      ),
    );
  }


  Widget _phone(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        controller: _phoneCon,
        textAlign: TextAlign.right,
        decoration: const InputDecoration(
          labelText: 'رقم الهاتف',
          alignLabelWithHint: true,
        ),
      ),
    );
  }


  Widget _username(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        controller: _usernameCon,
        textAlign: TextAlign.right,
        decoration: const InputDecoration(
          labelText: 'معرف المستخدم',
          alignLabelWithHint: true,
        ),
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        controller: _emailCon,
        textAlign: TextAlign.right,
        decoration: const InputDecoration(
          labelText: 'البريد الإلكتروني',
          alignLabelWithHint: true,
        ),
      ),
    );
  }

  Widget _passwordField(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        controller: _passwordCon,
        textAlign: TextAlign.right,
        obscureText: true,
        decoration: const InputDecoration(
          labelText: 'كلمة السر',
          alignLabelWithHint: true,
        ),
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.next,
      ),
    );
  }

  Widget _confirmPasswordField(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        controller: _confirmPasswordCon,
        textAlign: TextAlign.right,
        obscureText: true,
        decoration: const InputDecoration(
          labelText: 'تأكيد كلمة السر',
          alignLabelWithHint: true,
        ),
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
      ),
    );
  }


  Widget _address(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        controller: _addressCon,
        textAlign: TextAlign.right,
        decoration: const InputDecoration(
          labelText: 'العنوان',
          alignLabelWithHint: true,
        ),
      ),
    );
  }


  Widget _city(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        controller: _cityCon,
        textAlign: TextAlign.right,
        decoration: const InputDecoration(
          labelText: 'المدينة',
          alignLabelWithHint: true,
        ),
      ),
    );
  }


  Widget _postalCode(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        controller: _postalCodeCon,
        textAlign: TextAlign.right,
        decoration: const InputDecoration(
          labelText: 'الرمز البريدي',
          alignLabelWithHint: true,
        ),
      ),
    );
  }


  Widget _signupButton(BuildContext context) {
    return Builder(builder: (context) {
      return BasicReactiveButton(
        onPressed: () {
          context.read<ButtonStateCubit>().execute(
              usecase: sl<SignupUseCase>(),
              params: SignupReqParams(first_name: _firstNameCon.text,
                  last_name: _lastNameCon.text,
                  email: _emailCon.text,
                  phone: _phoneCon.text,
                  username: _usernameCon.text,
                  password: _passwordCon.text,
                  password_confirmation: _confirmPasswordCon.text,
                  address: _addressCon.text,
                  city: _cityCon.text,
                  postal_code: _postalCodeCon.text)
          ); // Add signup logic here
        },
        title: 'إنشاء حساب',
      );
    },
    );
  }

  Widget _loginInstead(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: "هل لديك حساب؟ ",
                style: AppTheme.blackTextStyle,
              ),
              TextSpan(
                text: 'تسجيل الدخول',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    AppNavigator.pop(context); // Navigate back to login
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

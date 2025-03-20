import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/common/bloc/button/button_state.dart';
import 'package:smartstore/common/bloc/button/button_state_cubit.dart';
import 'package:smartstore/common/widgets/appbar/app_bar.dart';
import 'package:smartstore/common/widgets/button/basic_reactive_button.dart';
import 'package:smartstore/features/authentication/data/models/signup_req_params.dart';
import 'package:smartstore/features/authentication/domain/usecases/signup.dart';
import '../../../../common/helper/navigator/app_navigator.dart';
import '../../../../service_locator.dart';
import '../../../home/presentation/pages/home.dart';

class SignupPageStep2 extends StatefulWidget {
  final String firstName, lastName, email, phone, username;

  const SignupPageStep2({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.username,
  });

  @override
  _SignupPageStep2State createState() => _SignupPageStep2State();
}

class _SignupPageStep2State extends State<SignupPageStep2> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordCon = TextEditingController();
  final TextEditingController _confirmPasswordCon = TextEditingController();
  final TextEditingController _addressCon = TextEditingController();
  final TextEditingController _cityCon = TextEditingController();

  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();

  @override
  void dispose() {
    _passwordCon.dispose();
    _confirmPasswordCon.dispose();
    _addressCon.dispose();
    _cityCon.dispose();

    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    _addressFocus.dispose();
    _cityFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CurvedAppBar(
        title: Text("إنشاء حساب"),
        hideBack: true,
        height: 135,
      ),
      body: BlocProvider(
        create: (context) => ButtonStateCubit(),
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonSuccessState) {
              AppNavigator.pushReplacement(context, HomePage());
            }
            if (state is ButtonFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
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
                      const SizedBox(height: 15),
                      _textField("كلمة السر", _passwordCon, _passwordFocus, _confirmPasswordFocus, obscureText: true),
                      _textField("تأكيد كلمة السر", _confirmPasswordCon, _confirmPasswordFocus, _addressFocus, obscureText: true),
                      _textField("العنوان", _addressCon, _addressFocus, _cityFocus),
                      _textField("المدينة", _cityCon, _cityFocus, null, isLastField: true),
                      const SizedBox(height: 15),
                      _signupButton(),
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

  Widget _textField(String label, TextEditingController controller, FocusNode currentFocus, FocusNode? nextFocus, {bool obscureText = false, bool isLastField = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          controller: controller,
          focusNode: currentFocus,
          textAlign: TextAlign.right,
          obscureText: obscureText,
          decoration: InputDecoration(
            labelText: label,
            alignLabelWithHint: true,
          ),
          keyboardType: obscureText ? TextInputType.visiblePassword : TextInputType.text,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "$label لا يمكن أن يكون فارغاً";
            }
            if (label == "كلمة السر" && value.length < 6) {
              return "يجب أن تكون كلمة السر 6 أحرف على الأقل";
            }
            if (label == "تأكيد كلمة السر" && value != _passwordCon.text) {
              return "كلمة السر غير متطابقة";
            }
            return null;
          },
          textInputAction: isLastField ? TextInputAction.done : TextInputAction.next,
          onFieldSubmitted: (_) {
            if (nextFocus != null) {
              FocusScope.of(context).requestFocus(nextFocus);
            }
          },
        ),
      ),
    );
  }

  Widget _signupButton() {
    return BlocBuilder<ButtonStateCubit, ButtonState>(
      builder: (context, state) {
        return BasicReactiveButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<ButtonStateCubit>().execute(
                usecase: sl<SignupUseCase>(),
                params: SignupReqParams(
                  first_name: widget.firstName,
                  last_name: widget.lastName,
                  email: widget.email,
                  phone: widget.phone,
                  username: widget.username,
                  password: _passwordCon.text,
                  password_confirmation: _confirmPasswordCon.text,
                  address: _addressCon.text,
                  city: _cityCon.text,
                  postal_code: "00000",
                ),
              );
            }
          },
          title: 'إنشاء حساب',
        );
      },
    );
  }
}
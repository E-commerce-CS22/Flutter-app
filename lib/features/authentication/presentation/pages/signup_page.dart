import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smartstore/common/widgets/appbar/app_bar.dart';
import 'package:smartstore/common/widgets/button/basic_app_button.dart';
import 'package:smartstore/core/configs/theme/app_colors.dart';
import 'package:smartstore/features/authentication/presentation/pages/signup_page_two.dart';
import '../../../../common/helper/navigator/app_navigator.dart';
import '../../../../core/configs/theme/app_theme.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _firstNameCon = TextEditingController();
  final TextEditingController _lastNameCon = TextEditingController();
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _phoneCon = TextEditingController();
  final TextEditingController _usernameCon = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // إنشاء FocusNodes
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _usernameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CurvedAppBar(
        title: Text("إنشاء حساب"),
        hideBack: true,
        height: 135,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _welcomeMessage(),
                  const SizedBox(height: 5),
                  _description(),
                  const SizedBox(height: 30),
                  _textField("الاسم الأول", _firstNameCon, _firstNameFocusNode, _lastNameFocusNode),
                  _textField("الاسم الأخير", _lastNameCon, _lastNameFocusNode, _emailFocusNode),
                  _textField("البريد الإلكتروني", _emailCon, _emailFocusNode, _phoneFocusNode, isEmail: true),
                  _textField("رقم الهاتف", _phoneCon, _phoneFocusNode, _usernameFocusNode, isPhone: true),
                  _textField("معرف المستخدم", _usernameCon, _usernameFocusNode, null, isLastField: true),
                  const SizedBox(height: 15),
                  _nextButton(),
                  const SizedBox(height: 15),
                  _loginInstead(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _welcomeMessage() {
    return Container(
      alignment: Alignment.center,
      child: const Text(
        'مرحباً بك!',
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: AppColors.primary),
      ),
    );
  }

  Widget _description() {
    return Container(
      alignment: Alignment.center,
      child: const Text(
        'أدخل المعلومات لإنشاء حساب جديد',
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.primary),
      ),
    );
  }

  Widget _textField(String label, TextEditingController controller, FocusNode currentFocusNode, FocusNode? nextFocusNode, {bool isEmail = false, bool isPhone = false, bool isLastField = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          controller: controller,
          focusNode: currentFocusNode,
          textAlign: TextAlign.right,
          keyboardType: isEmail ? TextInputType.emailAddress : (isPhone ? TextInputType.phone : TextInputType.text),
          decoration: InputDecoration(
            labelText: label,
            alignLabelWithHint: true,
          ),
          validator: (value) {
            value = value?.trim();
            if (value == null || value.isEmpty) {
              return "$label لا يمكن أن يكون فارغاً";
            }
            if (isEmail && !RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value)) {
              return "يرجى إدخال بريد إلكتروني صالح";
            }
            if (isPhone && !RegExp(r'^(77|78|71|73)\d{7}$').hasMatch(value)) {
              return "يرجى إدخال رقم هاتف صالح";
            }
            return null;
          },
          // تعيين Action الخاص بلوحة المفاتيح
          textInputAction: isLastField ? TextInputAction.done : TextInputAction.next,
          onFieldSubmitted: (value) {
            if (nextFocusNode != null) {
              FocusScope.of(context).requestFocus(nextFocusNode);  // الانتقال إلى الحقل التالي
            }
          },
        ),
      ),
    );
  }

  Widget _nextButton() {
    return BasicAppButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          AppNavigator.push(
            context,
            SignupPageStep2(
              firstName: _firstNameCon.text.trim(),
              lastName: _lastNameCon.text.trim(),
              email: _emailCon.text.trim(),
              phone: _phoneCon.text.trim(),
              username: _usernameCon.text.trim(),
            ),
          );
        }
      },
      title: 'التالي',
    );
  }

  Widget _loginInstead(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: RichText(
          text: TextSpan(
            children: [
              const TextSpan(text: "هل لديك حساب؟ ", style: AppTheme.blackTextStyle),
              TextSpan(
                text: 'تسجيل الدخول',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    AppNavigator.pop(context);
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
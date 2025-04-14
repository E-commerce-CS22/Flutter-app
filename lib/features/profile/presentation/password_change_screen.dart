import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/common/widgets/appbar/app_bar.dart';
import 'package:smartstore/common/widgets/button/basic_app_button.dart';

import '../domain/entities/password_change_params.dart';
import 'bloc/password_change_cubit.dart';
import 'bloc/password_change_state.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: BlocListener<PasswordChangeCubit, PasswordChangeState>(
        listener: (context, state) {
          if (state is PasswordChangeSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('تم تغيير كلمة المرور بنجاح'),
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              ),
            );
            Navigator.pop(context); // أو أي عملية تنقل أخرى
          } else if (state is PasswordChangeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: const Scaffold(
          appBar: CurvedAppBar(
            title: Text('تغيير كلمة المرور'),
            fontSize: 30,
          ),
          body: _ChangePasswordBody(),
        ),
      ),
    );
  }
}

class _ChangePasswordBody extends StatefulWidget {
  const _ChangePasswordBody();

  @override
  State<_ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<_ChangePasswordBody> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _oldPasswordCon = TextEditingController();
  final _newPasswordCon = TextEditingController();
  final _confirmPasswordCon = TextEditingController();

  // Password visibility flags
  bool _oldPasswordVisible = false;
  bool _newPasswordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  void dispose() {
    _oldPasswordCon.dispose();
    _newPasswordCon.dispose();
    _confirmPasswordCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildForm(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTextField('كلمة المرور القديمة', _oldPasswordCon, obscureText: !_oldPasswordVisible, toggleVisibility: () {
            setState(() {
              _oldPasswordVisible = !_oldPasswordVisible;
            });
          }),
          _buildTextField('كلمة المرور الجديدة', _newPasswordCon, obscureText: !_newPasswordVisible, toggleVisibility: () {
            setState(() {
              _newPasswordVisible = !_newPasswordVisible;
            });
          }),
          _buildTextField('تأكيد كلمة المرور الجديدة', _confirmPasswordCon, obscureText: !_confirmPasswordVisible, toggleVisibility: () {
            setState(() {
              _confirmPasswordVisible = !_confirmPasswordVisible;
            });
          }),
          const SizedBox(height: 20),
          _buildSaveButton(context),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text, bool obscureText = false, required VoidCallback toggleVisibility}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            labelText: label,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: toggleVisibility,
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'يرجى إدخال $label';
            }
            if (label == 'تأكيد كلمة المرور الجديدة' && value != _newPasswordCon.text) {
              return 'كلمة المرور غير متطابقة';
            }
            if (label == 'كلمة المرور الجديدة' && value.trim().length < 8) {
              return 'كلمة المرور يجب أن تحتوي على 8 أحرف على الأقل';
            }
            return null;
          },
        ),
      ),
    );
  }


  Widget _buildSaveButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BlocBuilder<PasswordChangeCubit, PasswordChangeState>(
        builder: (context, state) {
          if (state is PasswordChangeLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return BasicAppButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final passwordParams = PasswordChangeParams(
                  currentPassword: _oldPasswordCon.text.trim(),
                  password: _newPasswordCon.text.trim(),
                  passwordConfirm: _confirmPasswordCon.text.trim(),
                );
                context.read<PasswordChangeCubit>().changePassword(passwordParams);
              }
            },
            title: "حفظ التغييرات",
          );
        },
      ),
    );
  }
}
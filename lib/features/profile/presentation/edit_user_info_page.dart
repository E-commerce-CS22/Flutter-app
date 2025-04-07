import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/common/widgets/appbar/app_bar.dart';
import 'package:smartstore/common/widgets/button/basic_app_button.dart';
import 'package:smartstore/features/authentication/domain/entities/user.dart';
import 'package:smartstore/features/authentication/presentation/blocs/user_display_cubit.dart';
import 'package:smartstore/features/authentication/presentation/blocs/user_display_state.dart';
import '../domain/usecases/update_customer_info_use_case.dart';
import 'bloc/user_update_cubit.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: BlocProvider(
        create: (_) => UserUpdateCubit(),
        child: BlocListener<UserUpdateCubit, UserUpdateState>(
          listener: (context, state) {
            if (state is UserUpdateSuccess) {
              context.read<UserDisplayCubit>().displayUser();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('تم تحديث البيانات بنجاح'),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20)
                ),
              );
              Navigator.pop(context); // أو أي عملية تنقل
            } else if (state is UserUpdateError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errMessage)),
              );
            }
          },
          child: Scaffold(
            // تم إضافة Scaffold هنا
            appBar: CurvedAppBar(
              title: Text('تعديل البيانات'),
              fontSize: 30,
            ),
            body: const _EditProfileBody(),
          ),
        ),
      ),
    );
  }
}

class _EditProfileBody extends StatefulWidget {
  const _EditProfileBody();

  @override
  State<_EditProfileBody> createState() => _EditProfileBodyState();
}

class _EditProfileBodyState extends State<_EditProfileBody> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _firstNameCon = TextEditingController();
  final _lastNameCon = TextEditingController();
  final _emailCon = TextEditingController();
  final _usernameCon = TextEditingController();
  final _phoneCon = TextEditingController();
  final _cityCon = TextEditingController();
  final _addressCon = TextEditingController();

  @override
  void dispose() {
    _firstNameCon.dispose();
    _lastNameCon.dispose();
    _emailCon.dispose();
    _usernameCon.dispose();
    _phoneCon.dispose();
    _cityCon.dispose();
    _addressCon.dispose();
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
              BlocBuilder<UserDisplayCubit, UserDisplayState>(
                builder: (context, state) {
                  if (state is UserLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is UserLoaded) {
                    _populateUserData(state.userEntity);
                    return _buildForm(context);
                  } else if (state is LoadUserFailure) {
                    return Center(
                      child: Text(state.errorMessage,
                          style: const TextStyle(color: Colors.red)),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _populateUserData(UserEntity user) {
    _firstNameCon.text = user.first_name;
    _lastNameCon.text = user.last_name;
    _emailCon.text = user.email;
    _usernameCon.text = user.username;
    _phoneCon.text = user.phone;
    _cityCon.text = user.city;
    _addressCon.text = user.address;
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTextField('الاسم الأول', _firstNameCon),
          _buildTextField('اسم العائلة', _lastNameCon),
          _buildTextField('البريد الإلكتروني', _emailCon,
              keyboardType: TextInputType.emailAddress),
          _buildTextField('اسم المستخدم', _usernameCon),
          _buildTextField('رقم الهاتف', _phoneCon,
              keyboardType: TextInputType.phone),
          _buildTextField('المدينة', _cityCon),
          _buildTextField('العنوان', _addressCon),
          const SizedBox(height: 20),
          _buildSaveButton(context),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'يرجى إدخال $label';
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
      child: BasicAppButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final updatedFields = <String, dynamic>{};

            final currentState = context.read<UserDisplayCubit>().state;
            if (currentState is UserLoaded) {
              final user = currentState.userEntity;

              if (_firstNameCon.text.trim() != user.first_name) {
                updatedFields['first_name'] = _firstNameCon.text.trim();
              }
              if (_lastNameCon.text.trim() != user.last_name) {
                updatedFields['last_name'] = _lastNameCon.text.trim();
              }
              if (_emailCon.text.trim() != user.email) {
                updatedFields['email'] = _emailCon.text.trim();
              }
              if (_usernameCon.text.trim() != user.username) {
                updatedFields['username'] = _usernameCon.text.trim();
              }
              if (_phoneCon.text.trim() != user.phone) {
                updatedFields['phone'] = _phoneCon.text.trim();
              }
              if (_cityCon.text.trim() != user.city) {
                updatedFields['city'] = _cityCon.text.trim();
              }
              if (_addressCon.text.trim() != user.address) {
                updatedFields['address'] = _addressCon.text.trim();
              }

              if (updatedFields.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('لم يتم تعديل أي بيانات'),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
                  ),
                );
                return;
              }

              context.read<UserUpdateCubit>().updateUserProfile(
                    UpdateProfileParams(
                      firstName: updatedFields['first_name'],
                      lastName: updatedFields['last_name'],
                      email: updatedFields['email'],
                      username: updatedFields['username'],
                      phone: updatedFields['phone'],
                      city: updatedFields['city'],
                      address: updatedFields['address'],
                    ),
                  );
            }
          }
        },
        title: "حفظ التغييرات",
      ),
    );
  }
}

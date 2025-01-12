import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/common/bloc/button/button_state.dart';
import 'package:smartstore/common/helper/navigator/app_navigator.dart';
import 'package:smartstore/features/authentication/presentation/pages/welcome_page.dart';

import '../../../../../common/bloc/button/button_state_cubit.dart';
import '../../../../../common/widgets/appbar/app_bar.dart';
import '../../../../../core/configs/theme/app_colors.dart';
import '../../../../../service_locator.dart';
import '../../../../authentication/domain/usecases/logout.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Set the text direction to RTL
      child: BlocProvider<ButtonStateCubit>(  // Move the BlocProvider here
        create: (context) => ButtonStateCubit(),
        child: const Scaffold(
          appBar: CurvedAppBar(
            title: Text('حسابي'),
            height: 135,
            fontSize: 30,
          ),
          body: _ProfileBody(),
        ),
      ),
    );
  }
}


class _ProfileBody extends StatelessWidget {
  const _ProfileBody();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ButtonStateCubit, ButtonState>(
      listener: (context, state) {
        if (state is ButtonSuccessState) {
          AppNavigator.pushReplacement(context, WelcomePage());
        }
      },
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildProfileSection(),
              const _OrdersAndFavorites(),
              const Divider(thickness: 1.5),
              _buildAccountSettings(),
              const Divider(thickness: 1.5),
              _buildStoreAssistance(),
              const Divider(thickness: 1.5),
              _buildLogout(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey.shade300,
            child: Icon(Icons.person, size: 50, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          const Text(
            'حازم النكبة',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSettings() {
    return Column(
      children: [
        _buildSectionHeader('حسابي'),
        _buildAccountOption(
          title: 'إعدادات الملف الشخصي',
          onTap: () {
            // Handle Profile Settings
          },
        ),
        _buildAccountOption(
          title: 'عناوين الشحن',
          subOptions: [
            _buildSubOption(
              title: 'إضافة عنوان',
              description: 'عنوان توصيل جديد',
              icon: Icons.add_circle_outline,
              onTap: () {
                // Handle Add Address
              },
            ),
            _buildSubOption(
              title: 'جانب فلافل اللذيذ',
              description: 'جانب مشاوي النور، شارع الجامعة الجديد...',
              icon: Icons.more_vert,
              onTap: () {
                // Handle Edit Address
              },
            ),
          ],
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildStoreAssistance() {
    return Column(
      children: [
        _buildSectionHeader('مساعد المتجر'),
        _buildAccountOption(
          title: 'تواصل معنا',
          onTap: () {
            // Handle Contact Us
          },
        ),
        _buildAccountOption(
          title: 'الاستبدال والاسترجاع',
          onTap: () {
            // Handle Returns
          },
        ),
        _buildAccountOption(
          title: 'سياسة الخصوصية',
          onTap: () {
            // Handle Privacy Policy
          },
        ),
        _buildAccountOption(
          title: 'الشروط والأحكام',
          onTap: () {
            // Handle Terms and Conditions
          },
        ),
      ],
    );
  }

  Widget _buildLogout(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.logout, color: Colors.red),
      title: const Text(
        'تسجيل الخروج',
        style: TextStyle(color: Colors.red),
      ),
      onTap: () {
        context.read<ButtonStateCubit>().execute(
          usecase: sl<LogoutUseCase>(),
        );
        // Handle Logout
      },
    );
  }

  // Helper to build section headers
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Helper to build main account options
  Widget _buildAccountOption({
    required String title,
    List<Widget>? subOptions,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: onTap,
        ),
        if (subOptions != null) ...subOptions,
      ],
    );
  }

  // Helper to build sub-options under main options
  Widget _buildSubOption({
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.grey),
        title: Text(title),
        subtitle: Text(description),
        onTap: onTap,
      ),
    );
  }
}

class _OrdersAndFavorites extends StatelessWidget {
  const _OrdersAndFavorites();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildOption(
          icon: Icons.shopping_bag,
          label: 'طلباتي',
          onTap: () {
            // Navigate to Orders page
          },
        ),
        _buildOption(
          icon: Icons.favorite,
          label: 'المفضلة',
          onTap: () {
            // Navigate to Favorites page
          },
        ),
      ],
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: AppColors.gradient1, width: 1.0),
            ),
          ),
          child: Column(
            children: [
              Icon(icon, color: AppColors.gradient1),
              const SizedBox(height: 4),
              Text(label, style: const TextStyle(color: AppColors.black)),
            ],
          ),
        ),
      ),
    );
  }
}

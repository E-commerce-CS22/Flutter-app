import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartstore/common/bloc/auth/auth_state.dart';
import 'package:smartstore/common/helper/navigator/app_navigator.dart';
import 'package:smartstore/features/authentication/domain/entities/user.dart';
import 'package:smartstore/features/authentication/presentation/blocs/user_display_cubit.dart';
import 'package:smartstore/features/authentication/presentation/blocs/user_display_state.dart';
import 'package:smartstore/features/authentication/presentation/pages/welcome_page.dart';
import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../common/bloc/auth/auth_state_cubit.dart';
import '../../../../common/bloc/button/button_state.dart';
import '../../../../common/bloc/button/button_state_cubit.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../../../../service_locator.dart';
import '../../authentication/domain/usecases/logout.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ButtonStateCubit>(create: (_) => ButtonStateCubit()),
        ],
        child: BlocListener<AuthStateCubit, AuthState>(
          listener: (context, state) {
            if (state is UnAuthenticated) {
              AppNavigator.pushReplacement(context, WelcomePage());
            }
          },
          child: BlocListener<ButtonStateCubit, ButtonState>(
            listener: (context, state) {
              if (state is ButtonSuccessState) {
                AppNavigator.pushReplacement(context, WelcomePage());
              }
            },
            child: Scaffold(
              appBar: const CurvedAppBar(
                title: Text('حسابي'),
                fontSize: 30,
              ),
              body: const _ProfileBody(),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
    );
  }

  Widget _buildProfileSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<UserDisplayCubit, UserDisplayState>(
        builder: (context, state) {
          if (state is UserLoading) return _buildShimmerLoader();
          if (state is UserLoaded) {
            final user = state.userEntity;
            return Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade300,
                  child: const Icon(Icons.person, size: 50, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                  '${user.first_name} ${user.last_name}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            );
          }
          if (state is LoadUserFailure) {
            return Text(state.errorMessage, style: const TextStyle(color: Colors.red));
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildShimmerLoader() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,

      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 120,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildAccountSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeaderWithIcon('بيانات الحساب'),
        BlocBuilder<UserDisplayCubit, UserDisplayState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              final user = state.userEntity;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    _buildUserInfoRow('الاسم', "${user.first_name} ${user.last_name}"),
                    _buildUserInfoRow('البريد الإلكتروني', user.email),
                    _buildUserInfoRow('اسم المستخدم', user.username),
                    _buildUserInfoRow('رقم الهاتف', user.phone),
                    _buildUserInfoRow('المدينة', user.city),
                    _buildUserInfoRow('العنوان', user.address),
                  ],
                ),
              );
            } else if (state is LoadUserFailure) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'حدث خطأ أثناء تحميل البيانات: ${state.errorMessage}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }

  Widget _buildSectionHeaderWithIcon(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onTap: () {
              // Add your edit functionality here
            },
            child: Image.asset(
              'assets/icons/edit.png', // مسار الصورة
              width: 25,
              height: 25,
              color: AppColors.primary, // إذا كنت تريد تغيير لون الصورة
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildUserInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value ?? '-',
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }




  Widget _buildStoreAssistance() {
    return Column(
      children: [
        _buildSectionHeader('مساعد المتجر'),
        _buildAccountOption(title: 'تواصل معنا', onTap: () {}),
        _buildAccountOption(title: 'الاستبدال والاسترجاع', onTap: () {}),
        _buildAccountOption(title: 'سياسة الخصوصية', onTap: () {}),
        _buildAccountOption(title: 'الشروط والأحكام', onTap: () {}),
      ],
    );
  }

  Widget _buildLogout(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.logout, color: Colors.red),
      title: const Text('تسجيل الخروج', style: TextStyle(color: Colors.red)),
      onTap: () {
        context.read<AuthStateCubit>().logout();
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

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

  Widget _buildSubOption({
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
      children: [
        _buildOption(
          imagePath: 'assets/icons/orders.png',
          label: 'حاله طلباتي',
          onTap: () {},
        ),
        _buildOption(
          imagePath: 'assets/icons/password.png',
          label: 'تغيير كلمة المرور', // يمكن تقليل النص هنا ليكون أقصر
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildOption({
    required String imagePath,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: const BoxDecoration(
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center, // التأكد من محاذاة الصورة في المنتصف
                child: Image.asset(
                  imagePath,
                  width: 28,
                  height: 28,
                  fit: BoxFit.contain,
                  color: AppColors.primary, // لتطبيق اللون الأساسي
                ),
              ),
              const SizedBox(height: 2),
              Align(
                alignment: Alignment.center, // محاذاة النص في المنتصف أيضاً
                child: Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.black,
                    fontSize: 10,  // تقليل حجم النص
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

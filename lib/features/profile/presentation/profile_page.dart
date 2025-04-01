import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartstore/common/bloc/button/button_state.dart';
import 'package:smartstore/common/helper/navigator/app_navigator.dart';
import 'package:smartstore/features/authentication/domain/entities/user.dart';
import 'package:smartstore/features/authentication/presentation/blocs/user_display_cubit.dart';
import 'package:smartstore/features/authentication/presentation/blocs/user_display_state.dart';
import 'package:smartstore/features/authentication/domain/usecases/logout.dart';
import 'package:smartstore/features/authentication/presentation/pages/welcome_page.dart';
import '../../../../common/bloc/button/button_state_cubit.dart';
import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../service_locator.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserDisplayCubit()..displayUser()),
        BlocProvider(create: (context) => ButtonStateCubit()),
      ],
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
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileSection(),
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
          if (state is UserLoading) {
            return _buildShimmerLoader();
          }
          if (state is UserLoaded) {
            return Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade300,
                  child: const Icon(Icons.person, size: 50, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                _firstName(state.userEntity),
              ],
            );
          }
          if (state is LoadUserFailure) {
            return Text(
              state.errorMessage,
              style: const TextStyle(color: Colors.red, fontSize: 18),
            );
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

  Widget _firstName(UserEntity user) {
    return Text(
      '${user.first_name} ${user.last_name}',
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
      },
    );
  }
}

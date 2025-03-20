import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/common/bloc/button/button_state.dart';
import 'package:smartstore/common/bloc/button/button_state_cubit.dart';
import 'package:smartstore/common/widgets/appbar/app_bar.dart';
import 'package:smartstore/common/widgets/button/basic_reactive_button.dart';
import 'package:smartstore/core/configs/theme/app_colors.dart';
import 'package:smartstore/features/authentication/data/models/signup_req_params.dart';
import 'package:smartstore/features/authentication/domain/usecases/signup.dart';
import '../../../../common/helper/navigator/app_navigator.dart';
import '../../../../core/configs/theme/app_theme.dart';
import '../../../../service_locator.dart';
import '../../../home/presentation/pages/home.dart';


class SignupPageTwo extends StatelessWidget {
  const SignupPageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CurvedAppBar(
        title: Text("إنشاء حساب"),
        hideBack: true,
        height: 135,
      ),
    );
  }
}


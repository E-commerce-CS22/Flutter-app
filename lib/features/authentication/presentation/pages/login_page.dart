import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartstore/common/widgets/appbar/app_bar.dart';

import '../../../../core/configs/theme/app_colors.dart';

class loginPage extends StatelessWidget {
  const loginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CurvedAppBar(title: Text("تسجيل الدخول"),),
      body:Padding(
        padding: EdgeInsets.symmetric(
          horizontal:16,
          vertical:40
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          ],
        ),
      )
    );
  }
}


// Widget _welcomeMessage

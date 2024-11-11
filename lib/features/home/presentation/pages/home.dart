import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartstore/common/widgets/appbar/app_bar.dart';
// test
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CurvedAppBar(
        hideBack: true,
      ),

    );
  }
}

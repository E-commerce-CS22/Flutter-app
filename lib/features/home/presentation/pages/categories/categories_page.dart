// lib/pages/categories/categories_page.dart
import 'package:flutter/material.dart';
import 'package:smartstore/common/widgets/appbar/app_bar.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CurvedAppBar(
        title: const Text('الفئات'),
        height: 135,
        fontSize: 30,
      ),
      body: Center(
        child: Text(
          'Welcome to the Categories Page!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

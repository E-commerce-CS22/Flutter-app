// lib/pages/favorites/favorites_page.dart
import 'package:flutter/material.dart';
import 'package:smartstore/common/widgets/appbar/app_bar.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CurvedAppBar(
        title: const Text('المفضلة'),
        height: 135,
        fontSize: 30,
      ),
      body: Center(
        child: Text(
          'فارغ',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

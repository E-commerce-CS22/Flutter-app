import 'package:flutter/material.dart';
import 'package:smartstore/common/helper/navigator/app_navigator.dart';
import 'package:smartstore/common/widgets/appbar/app_bar.dart';
import 'package:smartstore/features/ai/ai_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CurvedAppBar(
        title: Text('الرئيسية'),
        height: 135,
        fontSize: 30,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            _SearchBox(),
            SizedBox(height: 20),
            _HomeContent(),
          ],
        ),
      ),
    );
  }
}

class _SearchBox extends StatelessWidget {
  const _SearchBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textDirection: TextDirection.rtl, // Set text direction to RTL
      decoration: InputDecoration(
        filled: true,
        // fillColor: Colors.grey[200],
        hintText: 'ابحث عن منتج...', // Arabic for "Search for a product..."
        hintTextDirection: TextDirection.rtl, // Hint text direction RTL
        suffixIcon: const Icon(Icons.search, color: Colors.grey), // Move icon to the right
        prefixIcon: GestureDetector(
            onTap: (){
              AppNavigator.push(context, ChatPage());
            },
            child: const Icon(Icons.smart_toy_outlined, color: Colors.grey)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
      onChanged: (value) {
        // Handle search logic here
      },
    );
  }
}


class _HomeContent extends StatelessWidget {
  const _HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          'مرحباً بك في الصفحة الرئيسية!', // Arabic for "Welcome to the Home Page!"
          style: const TextStyle(fontSize: 24),
          textDirection: TextDirection.rtl, // Content direction RTL
        ),
      ),
    );
  }
}

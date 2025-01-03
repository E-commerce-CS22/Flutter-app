// lib/pages/home/home_page.dart
import 'package:flutter/material.dart';
import 'package:smartstore/common/widgets/appbar/app_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CurvedAppBar(
        title: const Text('الرئيسية'),
        height: 135,
        fontSize: 30,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Modern search box (RTL)
            TextField(
              textDirection: TextDirection.rtl,  // Set text direction to RTL
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                hintText: 'ابحث عن منتج...',
                hintTextDirection: TextDirection.rtl, // Set hint text direction to RTL
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
              onChanged: (value) {
                // Handle search logic here
              },
            ),
            SizedBox(height: 20),
            // Content of the page
            Expanded(
              child: Center(
                child: Text(
                  'Welcome to the Home Page!',
                  style: TextStyle(fontSize: 24),
                  textDirection: TextDirection.rtl,  // Set content direction to RTL
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

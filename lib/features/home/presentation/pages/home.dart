import 'package:flutter/material.dart';
import '../../../../common/widgets/navbar/bottom_nav_bar.dart';
import '../../../../core/configs/theme/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // List of pages to display
  final List<Widget> _pages = [
    const Center(child: Text('Account', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Cart', style: TextStyle(fontSize: 24))),
    const Center(child: Text('categories', style: TextStyle(fontSize: 24))),
    const Center(child: Text('favorite', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Home', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white, // Match navigation bar color
      body: _pages[_currentIndex], // Display the current page
      bottomNavigationBar: CurvedNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the current page index
          });
        },
      ),
    );
  }
}

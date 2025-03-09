import 'package:flutter/material.dart';
import 'package:smartstore/common/helper/navigator/app_navigator.dart';
import 'package:smartstore/common/widgets/appbar/app_bar.dart';
import 'package:smartstore/features/ai/ai_page.dart';
import 'package:smartstore/features/home/presentation/pages/Home/models/category.dart';
import 'package:smartstore/features/home/presentation/pages/Home/widgets/categories.dart';
import 'package:smartstore/features/home/presentation/pages/Home/widgets/home_slider.dart';
import 'package:smartstore/features/home/presentation/pages/Home/widgets/search_box.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentSlide = 0; // Move this inside the stateful widget

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CurvedAppBar(
        title: Text('الرئيسية'),
        // height: 125,
        fontSize: 30,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SearchBox(),
              const SizedBox(height: 20),
              HomeSlider(
                onChange: (value) {
                  setState(() {
                    currentSlide = value;
                  });
                },
                currentSlide: currentSlide,
              ),
              const SizedBox(height: 20,),
              const Categories(),
            ],
          ),
        ),
      ),
    );
  }
}

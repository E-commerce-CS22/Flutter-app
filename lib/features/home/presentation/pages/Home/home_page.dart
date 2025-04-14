import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/common/widgets/appbar/app_bar.dart';
import 'package:smartstore/features/home/presentation/pages/Home/widgets/categories.dart';
import 'package:smartstore/features/home/presentation/pages/Home/widgets/home_slider.dart';
import 'package:smartstore/features/home/presentation/pages/Home/widgets/product_card.dart';
import 'package:smartstore/features/home/presentation/pages/Home/widgets/search_box.dart';
import 'package:smartstore/features/sliders/presentation/blocs/sliders_cubit.dart';
import 'package:smartstore/features/sliders/presentation/blocs/sliders_state.dart';
import 'package:smartstore/features/sliders/domain/entities/sliders_entity.dart';

import 'models/product.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentSlide = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SlidersCubit()..fetchSliders(),
      child: Scaffold(
        appBar: const CurvedAppBar(
          title: Text('الرئيسية'),
          fontSize: 30,
        ),
        body: BlocBuilder<SlidersCubit, SlidersState>(
          builder: (context, state) {
            List<SlideEntity> slides = [];

            if (state is SlidersLoaded) {
              slides = state.sliders;
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const SearchBox(),
                    const SizedBox(height: 20),

                    /// ✅ تمرير الصور إلى الـ HomeSlider
                    HomeSlider(
                      slides: slides,
                      currentSlide: currentSlide,
                      onChange: (value) {
                        setState(() {
                          currentSlide = value;
                        });
                      },
                    ),

                    const SizedBox(height: 20),
                    const Categories(),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text("عرض المزيد"),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.grey[600],
                          ),
                        ),
                        const Text(
                          "اخترنا لك",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: products[index]);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

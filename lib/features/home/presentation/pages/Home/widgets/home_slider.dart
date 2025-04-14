import 'package:flutter/material.dart';
import 'package:smartstore/features/sliders/domain/entities/sliders_entity.dart';
import 'package:smartstore/core/constants/api_urls.dart';
import 'package:shimmer/shimmer.dart';

class HomeSlider extends StatelessWidget {
  final List<SlideEntity> slides;
  final Function(int) onChange;
  final int currentSlide;

  const HomeSlider({
    super.key,
    required this.slides,
    required this.onChange,
    required this.currentSlide,
  });

  @override
  Widget build(BuildContext context) {
    if (slides.isEmpty) {
      return SizedBox(
        height: 180,
        child: _buildShimmerLoader(),
      );
    }

    return Stack(
      children: [
        SizedBox(
          height: 180,
          width: double.infinity,
          child: PageView.builder(
            reverse: true,
            onPageChanged: onChange,
            itemCount: slides.length,
            itemBuilder: (context, index) {
              final slide = slides[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  '${StaticUrls.baseURL}${slide.image}',
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 200,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return _buildShimmerLoader();
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      alignment: Alignment.center,
                      child: const Icon(Icons.error),
                    );
                  },
                ),
              );
            },
          ),
        ),
        Positioned.fill(
          bottom: 10,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                slides.length,
                    (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: currentSlide == index ? 15 : 8,
                  height: 8,
                  margin: const EdgeInsets.only(left: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: currentSlide == index
                        ? Colors.black
                        : Colors.transparent,
                    border: Border.all(color: Colors.black),
                  ),
                ),
              ).reversed.toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerLoader() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

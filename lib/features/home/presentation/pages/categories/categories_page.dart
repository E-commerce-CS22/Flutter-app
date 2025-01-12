import 'package:smartstore/common/widgets/appbar/app_bar.dart';
import 'package:smartstore/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AllCategoriesPage extends StatelessWidget {
  const AllCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality( // يضيف دعم RTL
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const CurvedAppBar(
          title: Text('الفئات'),
          height: 135,
          fontSize: 30,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _shopByCategories(),
              const SizedBox(height: 10),
              _categories(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _shopByCategories() {
    return const Text(
      'تسوق حسب الفئات', // النص مترجم إلى العربية
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    );
  }

  Widget _categories() {
    // بيانات تجريبية للفئات
    final categories = [
      {'title': 'الإلكترونيات', 'image': 'https://via.placeholder.com/150'},
      {'title': 'اكسسوارات', 'image': 'https://via.placeholder.com/150'},
      {'title': 'ادوات منزلية', 'image': 'https://via.placeholder.com/150'},
      {'title': 'الكتب', 'image': 'https://via.placeholder.com/150'},
    ];

    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          height: 70,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.secondBackground,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            textDirection: TextDirection.rtl, // يضمن اتجاه RTL للعناصر
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(categories[index]['image']!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Text(
                categories[index]['title']!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemCount: categories.length,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/common/widgets/appbar/app_bar.dart';
import 'package:smartstore/core/configs/theme/app_colors.dart';
import '../../../products_by_category/presentation/pages/products_by_category_screen.dart';
import '../blocs/category_cubit.dart';
import '../blocs/category_state.dart';

class AllCategoriesPage extends StatelessWidget {
  const AllCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const CurvedAppBar(
          title: Text('الفئات'),
          fontSize: 30,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<CategoryCubit>().displayCategories(); // إعادة تحميل الفئات
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(), // السماح بالسحب حتى لو لم يكن هناك عناصر كافية
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _shopByCategories(),
                  const SizedBox(height: 10),
                  _categoriesList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _shopByCategories() {
    return const Text(
      'تسوق حسب الفئات',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    );
  }

  Widget _categoriesList() {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoryLoaded) {
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            itemCount: state.categories.length,
            itemBuilder: (context, index) {
              var category = state.categories[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductsByCategoryScreen(
                        categoryId: category.id,
                        categoryName: category.name,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: AppColors.secondBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        child: category.image != null && category.image!.isNotEmpty
                            ? Image.network(
                          category.image!,
                          width: double.infinity,
                          height: 120,
                          fit: BoxFit.cover,
                        )
                            : Image.asset(
                          'assets/images/notFound.jpg',
                          width: double.infinity,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            category.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is LoadCategoryFailure) {
          return Center(
            child: Text(
              'خطأ: ${state.errorMessage}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          return const Center(child: Text('لا توجد بيانات متاحة'));
        }
      },
    );
  }
}

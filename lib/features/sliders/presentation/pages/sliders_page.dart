import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/core/constants/api_urls.dart';
import 'package:smartstore/features/sliders/presentation/blocs/sliders_cubit.dart';
import 'package:smartstore/features/sliders/presentation/blocs/sliders_state.dart';

class SlidersPage extends StatelessWidget {
  const SlidersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SlidersCubit()..fetchSliders(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('العروض'),
        ),
        body: BlocBuilder<SlidersCubit, SlidersState>(
          builder: (context, state) {
            if (state is SlidersLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SlidersError) {
              return Center(child: Text('خطأ: ${state.message}'));
            } else if (state is SlidersLoaded) {
              if (state.sliders.isEmpty) {
                return const Center(child: Text('لا توجد بيانات.'));
              }
              return ListView.builder(
                itemCount: state.sliders.length,
                itemBuilder: (context, index) {
                  final slide = state.sliders[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.network(
                          '${StaticUrls.baseURL}${slide.image}',
                          fit: BoxFit.cover, // ✅ يخلي الصورة بعرض الكرت وتظهر كاملة
                          height: 200,
                          errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 100),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Slide ID: ${slide.id} - Order: ${slide.order}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return const SizedBox(); // الحالة الافتراضية
          },
        ),
      ),
    );
  }
}

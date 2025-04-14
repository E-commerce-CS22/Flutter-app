import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/constants/api_urls.dart';  // تأكد من وضع رابط الـ API الصحيح
import '../../../../core/errors/failure.dart';  // لتعامل مع الأخطاء
import '../../../../core/network/dio_client.dart';  // لفئة Dio Client
import '../../../../service_locator.dart';
import '../models/sliders_model.dart';  // لتسجيل الخدمة

// نموذج API الخاص بالـ Sliders
abstract class SlidersApiService {
  Future<Either<Failure, List<SlideModel>>> getSliders();  // تعديل لاستقبال List<SlideModel>
}

class SlidersApiServiceImpl extends SlidersApiService {
  @override
  Future<Either<Failure, List<SlideModel>>> getSliders() async {
    try {
      // إرسال طلب GET إلى API للحصول على الـ Sliders
      final response = await sl<DioClient>().get(ApiUrls.sliders);

      final data = response.data;
      print('Response Data: $data');  // طباعة البيانات لتتأكد من صحتها

      if (data is! Map<String, dynamic>) {
        return Left(Failure(errMessage: 'بيانات غير متوقعة من السيرفر'));
      }

      // تحويل البيانات إلى List<SlideModel>
      List<SlideModel> slides = [];
      if (data['data'] != null && data['data'] is List) {
        slides = (data['data'] as List)
            .map((item) => SlideModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }

      // طباعة النموذج (SlideModel)
      slides.forEach((slide) {
        print('SlideModel Details:');
        print('ID: ${slide.id}');
        print('Order: ${slide.order}');
        print('Image: ${slide.image}');
      });

      // إرجاع البيانات بشكل صحيح
      return Right(slides);
    } on DioException catch (e) {
      // التعامل مع استثناءات Dio
      String message = 'حدث خطأ أثناء تحميل البيانات';
      if (e.response != null && e.response?.data != null) {
        message = e.response?.data['message'] ?? message;
      }
      return Left(Failure(errMessage: message));
    } catch (e) {
      print('❌ Error: $e');
      return Left(Failure(errMessage: 'حدث خطأ غير متوقع في API: $e'));
    }
  }
}

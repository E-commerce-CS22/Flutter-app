import '../../domain/entities/sliders_entity.dart';

class SlideModel extends SlideEntity {
  SlideModel({
    required super.id,
    required super.order,
    required super.image,
  });

  // تحويل JSON إلى كائن من نوع SlideModel
  factory SlideModel.fromJson(Map<String, dynamic> json) {
    List<SlideEntity> slideList = [];

    if (json['data'] != null && json['data'] is List) {
      slideList = (json['data'] as List)
          .map((item) => SlideModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return SlideModel(
      id: json['id'] ?? 0,  // تأكيد أن الـ id هو عدد صحيح
      order: json['order'] ?? 0,
      image: json['image'] ?? '',
    );
  }

  // تحويل الكائن إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order': order,
      'image': image,
    };
  }
}

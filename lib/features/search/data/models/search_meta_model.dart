import '../../domain/entities/search_meta_entity.dart';

class SearchMetaModel extends SearchMetaEntity {
  const SearchMetaModel({
    required super.currentPage,
    required super.from,
    required super.lastPage,
    required super.path,
    required super.perPage,
    required super.to,
    required super.total,
  });

  factory SearchMetaModel.fromJson(Map<String, dynamic> json) {
    return SearchMetaModel(
      currentPage: json['current_page'],
      from: json['from'],
      lastPage: json['last_page'],
      path: json['path'],
      perPage: json['per_page'],
      to: json['to'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'from': from,
      'last_page': lastPage,
      'path': path,
      'per_page': perPage,
      'to': to,
      'total': total,
    };
  }
}

import '../../domain/entities/attribute_entity.dart';

class AttributeModel extends AttributeEntity {
  AttributeModel({
    required super.attribute,
    required super.value,
  });

  factory AttributeModel.fromJson(Map<String, dynamic> json) {
    return AttributeModel(
      attribute: Attribute(
        id: json['attribute']['id'],
        name: json['attribute']['name'],
      ),
      value: AttributeValue(
        id: json['value']['id'],
        name: json['value']['name'],
      ),
    );
  }
}

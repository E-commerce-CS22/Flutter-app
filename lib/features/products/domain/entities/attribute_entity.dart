class AttributeEntity {
  final Attribute attribute;
  final AttributeValue value;

  AttributeEntity({
    required this.attribute,
    required this.value,
  });
}

class Attribute {
  final int id;
  final String name;

  Attribute({
    required this.id,
    required this.name,
  });
}

class AttributeValue {
  final int id;
  final String name;

  AttributeValue({
    required this.id,
    required this.name,
  });
}
import 'dart:convert';

class Price {
  final String? type;
  final double? price;

  Price({
    this.type,
    this.price,
  });

  Price copyWith({
    String? type,
    double? price,
  }) =>
      Price(
        type: type ?? this.type,
        price: price ?? this.price,
      );

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'price': price,
    };
  }

  factory Price.fromMap(Map<String, dynamic> map) {
    return Price(
      type: map['type'],
      price: map['price']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Price.fromJson(String source) => Price.fromMap(json.decode(source));
}

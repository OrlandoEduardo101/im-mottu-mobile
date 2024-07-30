import 'dart:convert';

import 'creators_item.dart';

class CreatorsModel {
  final int? available;
  final String? collectionUri;
  final List<CreatorsItem>? items;
  final int? returned;

  CreatorsModel({
    this.available,
    this.collectionUri,
    this.items,
    this.returned,
  });

  CreatorsModel copyWith({
    int? available,
    String? collectionUri,
    List<CreatorsItem>? items,
    int? returned,
  }) =>
      CreatorsModel(
        available: available ?? this.available,
        collectionUri: collectionUri ?? this.collectionUri,
        items: items ?? this.items,
        returned: returned ?? this.returned,
      );

  Map<String, dynamic> toMap() {
    return {
      'available': available,
      'collectionUri': collectionUri,
      'items': items?.map((x) => x.toMap()).toList(),
      'returned': returned,
    };
  }

  factory CreatorsModel.fromMap(Map<String, dynamic> map) {
    return CreatorsModel(
      available: map['available']?.toInt(),
      collectionUri: map['collectionUri'],
      items: map['items'] != null ? List<CreatorsItem>.from(map['items']?.map((x) => CreatorsItem.fromMap(x))) : null,
      returned: map['returned']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CreatorsModel.fromJson(String source) => CreatorsModel.fromMap(json.decode(source));
}

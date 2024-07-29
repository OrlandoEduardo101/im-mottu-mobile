import 'dart:convert';

import 'series_model.dart';

class CharactersSummaryModel {
  final int? available;
  final String? collectionUri;
  final List<Series>? items;
  final int? returned;

  CharactersSummaryModel({
    this.available,
    this.collectionUri,
    this.items,
    this.returned,
  });

  CharactersSummaryModel copyWith({
    int? available,
    String? collectionUri,
    List<Series>? items,
    int? returned,
  }) =>
      CharactersSummaryModel(
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

  factory CharactersSummaryModel.fromMap(Map<String, dynamic> map) {
    return CharactersSummaryModel(
      available: map['available']?.toInt(),
      collectionUri: map['collectionUri'],
      items: map['items'] != null ? List<Series>.from(map['items']?.map((x) => Series.fromMap(x))) : null,
      returned: map['returned']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CharactersSummaryModel.fromJson(String source) => CharactersSummaryModel.fromMap(json.decode(source));
}

import 'dart:convert';

import 'series_model.dart';

class EventsSummaryModel {
  final int? available;
  final String? collectionUri;
  final List<Series>? items;
  final int? returned;

  EventsSummaryModel({
    this.available,
    this.collectionUri,
    this.items,
    this.returned,
  });

  EventsSummaryModel copyWith({
    int? available,
    String? collectionUri,
    List<Series>? items,
    int? returned,
  }) =>
      EventsSummaryModel(
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

  factory EventsSummaryModel.fromMap(Map<String, dynamic> map) {
    return EventsSummaryModel(
      available: map['available']?.toInt(),
      collectionUri: map['collectionUri'],
      items: map['items'] != null ? List<Series>.from(map['items']?.map((x) => Series.fromMap(x))) : null,
      returned: map['returned']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory EventsSummaryModel.fromJson(String source) => EventsSummaryModel.fromMap(json.decode(source));
}

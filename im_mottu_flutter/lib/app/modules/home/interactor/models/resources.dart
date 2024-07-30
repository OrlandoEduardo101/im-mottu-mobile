import 'dart:convert';

import 'resource_item.dart';

class Resources {
  final int available;
  final String collectionUri;
  final List<ResourceItem> items;
  final int returned;

  Resources({
    required this.available,
    required this.collectionUri,
    required this.items,
    required this.returned,
  });

  Resources copyWith({
    int? available,
    String? collectionUri,
    List<ResourceItem>? items,
    int? returned,
  }) =>
      Resources(
        available: available ?? this.available,
        collectionUri: collectionUri ?? this.collectionUri,
        items: items ?? this.items,
        returned: returned ?? this.returned,
      );

  factory Resources.fromJson(String str) => Resources.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Resources.fromMap(Map<String, dynamic> json) => Resources(
        available: json["available"],
        collectionUri: json["collectionURI"],
        items: List<ResourceItem>.from(json["items"].map((x) => ResourceItem.fromMap(x))),
        returned: json["returned"],
      );

  Map<String, dynamic> toMap() => {
        "available": available,
        "collectionURI": collectionUri,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
        "returned": returned,
      };
}

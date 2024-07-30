import 'dart:convert';

class ResourceItem {
  final String resourceUri;
  final String name;

  ResourceItem({
    required this.resourceUri,
    required this.name,
  });

  ResourceItem copyWith({
    String? resourceUri,
    String? name,
  }) =>
      ResourceItem(
        resourceUri: resourceUri ?? this.resourceUri,
        name: name ?? this.name,
      );

  factory ResourceItem.fromJson(String str) => ResourceItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResourceItem.fromMap(Map<String, dynamic> json) => ResourceItem(
        resourceUri: json["resourceURI"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "resourceURI": resourceUri,
        "name": name,
      };
}

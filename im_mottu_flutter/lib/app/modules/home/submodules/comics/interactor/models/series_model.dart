import 'dart:convert';

class Series {
  final String? resourceUri;
  final String? name;

  Series({
    this.resourceUri,
    this.name,
  });

  Series copyWith({
    String? resourceUri,
    String? name,
  }) =>
      Series(
        resourceUri: resourceUri ?? this.resourceUri,
        name: name ?? this.name,
      );

  Map<String, dynamic> toMap() {
    return {
      'resourceUri': resourceUri,
      'name': name,
    };
  }

  factory Series.fromMap(Map<String, dynamic> map) {
    return Series(
      resourceUri: map['resourceUri'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Series.fromJson(String source) => Series.fromMap(json.decode(source));
}

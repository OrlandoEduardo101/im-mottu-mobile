import 'dart:convert';

class CreatorsItem {
  final String? resourceUri;
  final String? name;
  final String? role;

  CreatorsItem({
    this.resourceUri,
    this.name,
    this.role,
  });

  CreatorsItem copyWith({
    String? resourceUri,
    String? name,
    String? role,
  }) =>
      CreatorsItem(
        resourceUri: resourceUri ?? this.resourceUri,
        name: name ?? this.name,
        role: role ?? this.role,
      );

  Map<String, dynamic> toMap() {
    return {
      'resourceUri': resourceUri,
      'name': name,
      'role': role,
    };
  }

  factory CreatorsItem.fromMap(Map<String, dynamic> map) {
    return CreatorsItem(
      resourceUri: map['resourceUri'],
      name: map['name'],
      role: map['role'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CreatorsItem.fromJson(String source) => CreatorsItem.fromMap(json.decode(source));
}

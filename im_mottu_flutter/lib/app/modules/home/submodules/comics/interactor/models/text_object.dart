import 'dart:convert';

class TextObject {
  final String? type;
  final String? language;
  final String? text;

  TextObject({
    this.type,
    this.language,
    this.text,
  });

  TextObject copyWith({
    String? type,
    String? language,
    String? text,
  }) =>
      TextObject(
        type: type ?? this.type,
        language: language ?? this.language,
        text: text ?? this.text,
      );

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'language': language,
      'text': text,
    };
  }

  factory TextObject.fromMap(Map<String, dynamic> map) {
    return TextObject(
      type: map['type'],
      language: map['language'],
      text: map['text'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TextObject.fromJson(String source) => TextObject.fromMap(json.decode(source));
}

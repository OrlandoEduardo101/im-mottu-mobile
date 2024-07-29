import 'dart:convert';

class DateItem {
  final String? type;
  final DateTime? date;

  DateItem({
    this.type,
    this.date,
  });

  DateItem copyWith({
    String? type,
    DateTime? date,
  }) =>
      DateItem(
        type: type ?? this.type,
        date: date ?? this.date,
      );

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'date': date?.toIso8601String(),
    };
  }

  factory DateItem.fromMap(Map<String, dynamic> map) {
    return DateItem(
      type: map['type'],
      date: DateTime.tryParse(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DateItem.fromJson(String source) => DateItem.fromMap(json.decode(source));
}

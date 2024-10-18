import 'dart:convert';

class TodoModel {
  final String title;
  final String description;
  final DateTime dateTime;
  final String priority;
  TodoModel({
    required this.title,
    required this.description,
    required this.dateTime,
    required this.priority,
  });

  TodoModel copyWith({
    String? title,
    String? description,
    DateTime? dateTime,
    String? priority,
  }) {
    return TodoModel(
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      priority: priority ?? this.priority,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'priority': priority,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      title: map['title'] as String,
      description: map['description'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      priority: map['priority'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TodoModel(title: $title, description: $description, dateTime: $dateTime, priority: $priority)';
  }

  @override
  bool operator ==(covariant TodoModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.description == description &&
        other.dateTime == dateTime &&
        other.priority == priority;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        dateTime.hashCode ^
        priority.hashCode;
  }
}

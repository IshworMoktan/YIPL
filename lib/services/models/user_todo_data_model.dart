class UserTodo {
  final int id;
  final int userId;
  final String title;
  final bool completed;

  UserTodo({
    required this.id,
    required this.userId,
    required this.title,
    required this.completed,
  });

  factory UserTodo.fromJson(Map<String, dynamic> json) {
    return UserTodo(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'completed': completed,
    };
  }

  UserTodo copyWith({
    int? id,
    int? userId,
    String? title,
    bool? completed,
  }) {
    return UserTodo(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }
}

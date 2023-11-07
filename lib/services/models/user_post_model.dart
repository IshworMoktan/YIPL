class UserPost {
  final int id;
  final int userId;
  final String title;
  final String body;

  UserPost({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory UserPost.fromJson(Map<String, dynamic> json) {
    return UserPost(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }
}

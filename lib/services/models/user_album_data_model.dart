class UserAlbum {
  final int id;
  final int userId;
  final String title;

  UserAlbum({required this.id, required this.userId, required this.title});

  factory UserAlbum.fromJson(Map<String, dynamic> json) {
    return UserAlbum(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
    );
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory Post.fromMap(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  toJson() {
    return {
      "userId": userId,
      "id": id,
      "title": title,
      "body": body,
    };
  }
}

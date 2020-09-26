import 'dart:convert';
import 'package:flutter_app/core/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HttpService {
  final String postsURL =
      "https://my-json-server.typicode.com/TarekFahm/httpRequest/posts";

  Future<List<Post>> getPosts() async {
    Response res = await get(postsURL);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Post> posts = body
          .map(
            (dynamic item) => Post.fromJson(item),
          )
          .toList();

      return posts;
    } else {
      throw "Can't get posts.";
    }
  }

  // we have no access to the api, so we can't delete or modify the records

  Future<Post> updatePosts({String title, id, body}) async {
    String urlToUpdate = '$postsURL/$id';
    print(urlToUpdate);
    Response response = await put(
      urlToUpdate,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'title': title, 'body': body}),
    );

    if (response.statusCode == 200) {
      print(Post.fromJson(jsonDecode(response.body)).id);
      print(Post.fromJson(jsonDecode(response.body)).body);
      print(Post.fromJson(jsonDecode(response.body)).title);
      return Post.fromJson(json.decode(response.body));
    } else {
      throw "Can't update posts.";
    }
  }

  Future<Post> newPosts(String userId, title, id, body) async {
    Response res = await post(
      postsURL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': userId,
        'id': id,
        'title': title,
        'body': body
      }),
    );

    if (res.statusCode == 200) {
      return Post.fromJson(json.decode(res.body));
    } else {
      throw "Can't post.";
    }
  }

  Future<Post> deletePost(String id) async {
    String postToDelete = '$postsURL/$id';
    print(postToDelete);
    final http.Response response = await http.delete(
      postToDelete,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(Post.fromJson(jsonDecode(response.body)).id);
      print(Post.fromJson(jsonDecode(response.body)).body);
      print(Post.fromJson(jsonDecode(response.body)).title);
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to delete post.');
    }
  }
}

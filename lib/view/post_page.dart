import 'package:flutter/material.dart';
import 'package:flutter_app/core/models/post.dart';
import 'package:flutter_app/core/service/http_service.dart';
import 'package:flutter_app/view/posts_details.dart';

// ignore: must_be_immutable
class PostPage extends StatelessWidget {
  final HttpService httpService = HttpService();
  final Post post = Post();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Posts',
          style: TextStyle(
            fontSize: 28,
          ),
        ),
      ),
      body: FutureBuilder(
        future: httpService.getPosts(),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.hasData) {
            List<Post> posts = snapshot.data;
            return ListView(
              children: posts
                  .map((Post post) => Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Card(
                          color: Colors.black54,
                          child: ListTile(
                            contentPadding: EdgeInsets.all(15.0),
                            title: Text(
                              "${post.id}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                            subtitle: Text(
                              post.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PostDetail(
                                  post: post,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

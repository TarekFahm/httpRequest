import 'package:flutter/material.dart';
import 'package:flutter_app/core/models/post.dart';
import 'package:flutter_app/core/service/http_service.dart';

class PostDetail extends StatefulWidget {
  final Post post;

  PostDetail({@required this.post});

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  String newTitle;
  String newBody;

  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    updateDialog() => showDialog<void>(
          context: context,
          barrierDismissible: true,
          // false = user must tap button, true = tap outside dialog
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: Text('Please Enter Your New Data'),
              content: Container(
                height: 100,
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(hintText: 'Enter Your New Title'),
                      onChanged: (string) {
                        setState(() {
                          newTitle = string;
                        });
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: 'Enter Your New Body'),
                      onChanged: (string) {
                        newBody = string;
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Update My Data'),
                  onPressed: () async {
                    await httpService.updatePosts(
                        title: newTitle, body: newBody, id: widget.post.id.toString());
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(widget.post.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await httpService.deletePost(widget.post.id.toString());
                Navigator.of(context).pop();
              },
            ),
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  updateDialog();
                }),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "User ID",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "${widget.post.userId}",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Post ID",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "${widget.post.id}",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Title",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          widget.post.title,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Body",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          widget.post.body,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

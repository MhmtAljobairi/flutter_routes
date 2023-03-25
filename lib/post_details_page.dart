import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:helloworldfullter/controllers/post_controller.dart';
import 'package:helloworldfullter/models/comment.dart';
import 'package:helloworldfullter/models/post.dart';

class PostDetailsPage extends StatefulWidget {
  int id;
  PostDetailsPage(this.id, {super.key});

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  Post? post;
  List<Comment> comments = [];

  @override
  void initState() {
    super.initState();
    _getPostDetails();
    _getPostComments();
  }

  _getPostDetails() {
    EasyLoading.show(status: "Loading");
    PostController().getById(widget.id).then((value) {
      EasyLoading.dismiss();
      setState(() {
        post = value;
      });
    }).catchError((ex) {
      EasyLoading.dismiss();
      EasyLoading.showError(ex.toString());
    });
  }

  _getPostComments() {
    PostController().getCommentsById(widget.id).then((value) {
      setState(() {
        comments = value;
      });
    }).catchError((ex) {
      EasyLoading.dismiss();
      EasyLoading.showError(ex.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Post Details")),
        body: post == null ? _widgetWaiting() : _widgetPostDetails());
  }

  Widget _widgetWaiting() => Visibility(
        visible: post == null,
        child: Center(child: CircularProgressIndicator()),
      );

  Widget _widgetPostDetails() => Column(
        children: [
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text("ID"),
                        ),
                        Expanded(
                            flex: 3,
                            child: Text(
                              "${post!.id}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text("Title"),
                        ),
                        Expanded(
                            flex: 3,
                            child: Text(
                              post!.title,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text("Body"),
                        ),
                        Expanded(
                            flex: 3,
                            child: Text(
                              post!.body,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))
                      ],
                    )
                  ],
                ),
              )),
          const Divider(),
          Expanded(
              flex: 3,
              child: ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) => ListTile(
                        title: Text(comments[index].name),
                        subtitle: Text(comments[index].email),
                      )))
        ],
      );
}

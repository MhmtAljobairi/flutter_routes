import 'package:flutter/material.dart';
import 'package:helloworldfullter/controllers/post_controller.dart';
import 'package:helloworldfullter/models/post.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  List<Post> _posts = [];

  @override
  void initState() {
    super.initState();
    _getAllPosts();
  }

  _getAllPosts() async {
    PostController().getAll().then((result) {
      setState(() {
        _posts = result;
      });
    }).catchError((ex) {
      print(ex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Posts"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/postForm");
          },
          child: Icon(Icons.add),
        ),
        body: _posts.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemCount: _posts.length,
                separatorBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Divider(),
                    ),
                itemBuilder: (context, index) => ListTile(
                      title: Text(_posts[index].title),
                      subtitle: Text(_posts[index].body),
                      onTap: () {
                        Navigator.pushNamed(context, "/postDetails",
                            arguments: _posts[index].id);
                      },
                    )));
  }
}

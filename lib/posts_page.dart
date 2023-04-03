import 'package:flutter/material.dart';
import 'package:helloworldfullter/controllers/post_controller.dart';
import 'package:helloworldfullter/models/post.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  void initState() {
    super.initState();
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
        body: FutureBuilder<List<Post>>(
          future: PostController().getAll(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                  child: Text("There are an error, please try again"));
            }
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.separated(
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (context, index) => const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(),
                      ),
                  itemBuilder: (context, index) => ListTile(
                        title: Text(snapshot.data![index].title),
                        subtitle: Text(snapshot.data![index].body),
                        onTap: () {
                          Navigator.pushNamed(context, "/postDetails",
                              arguments: snapshot.data![index].id);
                        },
                      ));
            }
          },
        ));
  }
}

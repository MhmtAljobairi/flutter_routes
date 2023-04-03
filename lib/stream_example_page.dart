import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helloworldfullter/models/post.dart';

class StreamExamplePage extends StatefulWidget {
  const StreamExamplePage({super.key});

  @override
  State<StreamExamplePage> createState() => _StreamExamplePageState();
}

class _StreamExamplePageState extends State<StreamExamplePage> {
  final postsRef = FirebaseFirestore.instance.collection("posts");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stream Example")),
      body: StreamBuilder<QuerySnapshot>(
        stream: postsRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.none) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Center(child: Text("There are an error, please try again"));
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Post> posts =
                snapshot.data!.docs.map((e) => Post.fromQuery(e)).toList();

            List<Post> postsReversed = posts.reversed.toList();

            return ListView.separated(
                itemCount: postsReversed.length,
                separatorBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Divider(),
                    ),
                itemBuilder: (context, index) => ListTile(
                      title: Text(postsReversed[index].title),
                      subtitle: Text(postsReversed[index].body),
                      onTap: () {
                        Navigator.pushNamed(context, "/postDetails",
                            arguments: postsReversed[index].id);
                      },
                    ));
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

class GridViewPage extends StatefulWidget {
  const GridViewPage({super.key});

  @override
  State<GridViewPage> createState() => _GridViewPageState();
}

class _GridViewPageState extends State<GridViewPage> {
  List<Map> users = List.generate(
      100,
      (index) => {
            "id": index + 1,
            "name": "Name ${index + 1}",
          }).toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Grid View Example"),
      ),
      body: GridView.builder(
          itemCount: users.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 120.0,
            childAspectRatio: 1.0,
            mainAxisSpacing: 0.0, // Horizatally.
            crossAxisSpacing: 0.0, // Vertically
          ),
          itemBuilder: (context, index) => Column(
                children: [
                  const CircleAvatar(),
                  Text(users[index]["name"]),
                ],
              )),
    );
  }
}

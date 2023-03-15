import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({super.key});

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  List<Map> users = List.generate(
      50,
      (index) => {
            "id": index + 1,
            "name": "Name ${index + 1}",
          }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("List View Example")),
        body:
            // ListView.builder(
            //   itemCount: users.length,
            //   itemBuilder: ((context, index) => _widgetItem(index)),
            // ),
            ListView.separated(
          itemCount: users.length,
          itemBuilder: ((context, index) => _widgetItem(index)),
          separatorBuilder: (context, index) => const Divider(),
        )
        // itemBuilder: ((context, index) {
        //   return Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text(users[index]["name"]),
        //       ElevatedButton(
        //         onPressed: () {},
        //         child: Text("Click me!"),
        //       )
        //     ],
        //   );
        // })
        );
  }

  Row _widgetItem(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(users[index]["name"]),
        ElevatedButton(
          onPressed: () {
            setState(() {
              users.removeAt(index);
            });
          },
          child: Text("Click me!"),
        )
      ],
    );
  }
}

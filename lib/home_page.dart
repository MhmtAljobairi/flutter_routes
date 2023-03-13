import 'package:flutter/material.dart';
import 'package:helloworldfullter/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool visible = true;
  @override
  Widget build(BuildContext context) {
    dynamic user = ModalRoute.of(context)!.settings.arguments as dynamic;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Hello ${user['email'].toString()}"),
          Visibility(
              visible: visible,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, "Hello Back");
                  },
                  child: Text("Back"))),
        ],
      )),
    );
  }
}

// class HomePage extends StatelessWidget {
//   String email;
//   HomePage({super.key, required this.email});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Home Page"),
//       ),
//       body: Center(child: Text("Hello ${email.toString()}")),
//     );
//   }
// }

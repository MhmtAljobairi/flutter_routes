import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helloworldfullter/controllers/user_controller.dart';
import 'package:helloworldfullter/main.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? token;
  @override
  void initState() {
    super.initState();
  }

  bool visible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: FutureBuilder<User>(
        future: UserController().getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error,
                  size: 100,
                  color: Colors.red,
                ),
                Text("An error occured, please tru later")
              ],
            ));
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Hello ${snapshot.data!.fullName}"),
              Visibility(
                  visible: visible,
                  child: ElevatedButton(
                      onPressed: () async {
                        var storage = FlutterSecureStorage();
                        await storage.deleteAll();
                        Navigator.pushReplacementNamed(context, "/login");
                      },
                      child: Text("Logout"))),
            ],
          ));
        },
      ),
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

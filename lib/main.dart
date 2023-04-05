import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helloworldfullter/bottom_tabs_page.dart';
import 'package:helloworldfullter/controllers/user_controller.dart';
import 'package:helloworldfullter/custom_tab_page.dart';
import 'package:helloworldfullter/firestore_crud_page.dart';
import 'package:helloworldfullter/post_form_page.dart';
import 'package:helloworldfullter/posts_page.dart';
import 'package:helloworldfullter/gridview_page.dart';
import 'package:helloworldfullter/home_page.dart';
import 'package:helloworldfullter/model.dart';
import 'package:helloworldfullter/post_details_page.dart';
import 'package:helloworldfullter/stream_example_page.dart';
import 'package:helloworldfullter/tab_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      builder: EasyLoading.init(),
      theme: ThemeData(
          // useMaterial3: true,
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.orange),
      // home: MyFirstStatefulWidget(),
      initialRoute: "/",
      onGenerateRoute: (settings) {
        var routes = {
          // "/": (context) => PreLoadPage(),
          // "/listview": (context) => ListViewPage(),

          "/": (context) => FirestoreCrudPage(),
          "/postDetails": (context) =>
              PostDetailsPage(settings.arguments as int),
          "/gridView": (context) => GridViewPage(),
          "/posts": (context) => PostsPage(),
          "/stream": (context) => StreamExamplePage(),
          "/postForm": (context) => PostFormPage(),
          "/bottomTab": (context) => BottomTabsPage(),
          "/tabs": (context) => TabPage(),
          "/customTab": (context) => CustomTabPage(),
          "/home": (context) => HomePage(),
          "/login": (context) => MyFirstStatefulWidget(),
        };
        WidgetBuilder builder = routes[settings.name]!;
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      },
    );
  }
}

class PreLoadPage extends StatefulWidget {
  const PreLoadPage({super.key});

  @override
  State<PreLoadPage> createState() => _PreLoadPageState();
}

class _PreLoadPageState extends State<PreLoadPage> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  _checkLogin() async {
    var storage = FlutterSecureStorage();
    var checker = await storage.containsKey(key: "token");
    if (checker) {
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MyFirstStatefulWidget extends StatefulWidget {
  const MyFirstStatefulWidget({super.key});

  @override
  State<MyFirstStatefulWidget> createState() => _MyFirstStatefulWidgetState();
}

class _MyFirstStatefulWidgetState extends State<MyFirstStatefulWidget> {
  bool obscureText = true;
  final _keyForm = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text("Login Page")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _keyForm,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FlutterLogo(
                    size: 100,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !EmailValidator.validate(value)) {
                        return "Please enter an email address";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: "example@john.com",
                        prefixIcon: Icon(Icons.email)),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordController,
                    obscureText: obscureText,
                    validator: (value) {
                      if (value == null || value.length < 2) {
                        return "Please enter an valid password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "*******",
                        suffix: InkWell(
                          onTap: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          child: obscureText
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                        prefixIcon: const Icon(Icons.password)),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _handleLoginAction();
                      },
                      child: const Text("Login"),
                    ),
                  ),
                ])),
      ),
    );
  }

  _handleLoginAction() async {
    if (_keyForm.currentState!.validate()) {
      String email = emailController.text;
      String password = passwordController.text;

      User user = User(email: email, password: password, fullName: "");
      EasyLoading.show(status: "Loading");
      UserController().login(user).then((value) {
        EasyLoading.dismiss();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }).catchError((ex) {
        EasyLoading.dismiss();
        EasyLoading.showError(ex.toString());
      });

      // // App 1
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => HomePage(user)));

      // // App 2
      // dynamic result =
      //     await Navigator.pushNamed(context, "/home", arguments: user);

      // print(result);
    }
  }
}

class User {
  String email;
  String password;
  String fullName;

  User({required this.email, required this.password, required this.fullName});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json["email"],
      password: json["password"],
      fullName: json["full_name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
    };
  }
}

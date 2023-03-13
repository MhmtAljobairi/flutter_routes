import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:helloworldfullter/home_page.dart';
import 'package:helloworldfullter/model.dart';

void main() {
  Model model = Model(
    id: 1,
    email: "m@m.com",
    name: "Mhmd",
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
      initialRoute: "/login",
      routes: {
        "/home": (context) => HomePage(),
        "/login": (context) => MyFirstStatefulWidget(),
      },
    );
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
                      if (value == null || value.length < 6) {
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

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => HomePage(
      //               email: email,
      //             )));

      // dynamic result = await Navigator.pushNamed(context, "/home",
      //     arguments: User(email: email, password: password));

      // dynamic result = await Navigator.pushNamed(context, "/home",
      //     arguments: {"email": email, "password": password});

      dynamic result = await Navigator.pushNamed(context, "/home",
          arguments: [email, password]);
      print(result);
    }
  }
}

class User {
  String email;
  String password;

  User({required this.email, required this.password});
}
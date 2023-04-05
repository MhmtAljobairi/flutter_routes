import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:helloworldfullter/models/user_model.dart';
import 'package:intl/intl.dart';

class FirestoreCrudPage extends StatefulWidget {
  const FirestoreCrudPage({super.key});

  @override
  State<FirestoreCrudPage> createState() => _FirestoreCrudPageState();
}

class _FirestoreCrudPageState extends State<FirestoreCrudPage> {
  final collection = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My App")),
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
                onPressed: () {
                  _handleAddUserAction();
                },
                child: Text("Add User")),
            ElevatedButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2024));
                  print(pickedDate!.toLocal());

                  DateFormat format = DateFormat("yyyy MMM dd");
                  print(format.format(pickedDate));
                },
                child: Text("Show Date")),
            ElevatedButton(
                onPressed: () async {
                  TimeOfDay? pickedDate = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      initialEntryMode: TimePickerEntryMode.dial);
                  print(pickedDate);
                },
                child: Text("Show Time")),
          ],
        ),
        Expanded(
            child: StreamBuilder<QuerySnapshot>(
          stream: collection.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("There are some error happened"));
            }
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            List<UserModel> users =
                snapshot.data!.docs.map((e) => UserModel.fromQuery(e)).toList();

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    _handleDeleteUserAction(users[index].id!);
                  },
                  title: Text(users[index].fullName),
                  subtitle: Text(users[index].email),
                  trailing: TextButton(
                    onPressed: () {
                      _handleUpdateUserAction(users[index]);
                    },
                    child: Text("Edit"),
                  ),
                );
              },
            );
          },
        ))
      ]),
    );
  }

  _handleAddUserAction() {
    EasyLoading.show(status: "Loading");

    UserModel user = UserModel(
      fullName: "Ahmad",
      birthdate: "2023-01-01",
      email: "m2@m2.com",
    );
    collection.add(user.toJson()).then((value) {
      EasyLoading.dismiss();
      EasyLoading.showSuccess(value.id);
    }).catchError((ex) {
      EasyLoading.dismiss();
      EasyLoading.showError(ex.toString());
    });
  }

  _handleDeleteUserAction(String id) {
    EasyLoading.show(status: "Loading");
    collection.doc(id).delete().then((value) {
      EasyLoading.dismiss();
      EasyLoading.showSuccess("$id has been deleted!");
    }).catchError((ex) {
      EasyLoading.dismiss();
      EasyLoading.showError(ex.toString());
    });
  }

  _handleUpdateUserAction(UserModel user) {
    EasyLoading.show(status: "Loading");
    user.fullName = "Khalid";
    user.address = "Amman";
    collection.doc(user.id!).set(user.toJson()).then((value) {
      EasyLoading.dismiss();
      EasyLoading.showSuccess("${user.id!} has been Updated!");
    }).catchError((ex) {
      EasyLoading.dismiss();
      EasyLoading.showError(ex.toString());
    });
  }
}

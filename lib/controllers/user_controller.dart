import 'package:helloworldfullter/controllers/api_helper.dart';
import 'package:helloworldfullter/main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserController {
  Future<bool> login(User user) async {
    try {
      dynamic jsonObject =
          await ApiHelper().postRequest("api/users/login", user.toJson());
      String type = jsonObject["type"];
      String token = jsonObject["token"];
      var storage = FlutterSecureStorage();
      await storage.write(key: "token", value: "$type $token");
      return true;
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<User> getUser() async {
    dynamic jsonObject = await ApiHelper().getRequest("api/users");
    return User.fromJson(jsonObject);
  }
}

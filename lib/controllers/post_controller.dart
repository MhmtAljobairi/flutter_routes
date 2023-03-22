import 'package:helloworldfullter/controllers/api_helper.dart';
import 'package:helloworldfullter/models/post.dart';

class PostController {
  Future<List<Post>> getAll() async {
    dynamic jsonObject = await ApiHelper().getRequest("posts");
    List<Post> result = [];
    jsonObject.forEach((json) {
      result.add(Post.fromJson(json));
    });
    return result;
  }
}

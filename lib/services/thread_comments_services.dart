import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socioverse/Models/threadModel.dart';

class ThreadCommentServices {
  static ApiResponse _response = ApiResponse();

  static Future<List<ThreadModel>?> fetchThreadReplies(String threadId) async {
    _response = await ApiHelper.get(
      ApiStringConstants.fetchAllThreadComments,
      querryParam: {"commentId": threadId},
      isPublic: false,
    );
    if (_response.success == false) {
      return null;
    }
    List<ThreadModel>? threadReplies = [];
    _response.data.forEach((element) {
      threadReplies.add(ThreadModel.fromJson(element));
    });
    return threadReplies;
  }
}

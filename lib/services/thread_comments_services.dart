import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socioverse/Models/threadModel.dart';

class ThreadCommentServices {
  ApiHelper _helper = ApiHelper();
  ApiResponse _response = ApiResponse();

  Future<List<ThreadModel>> fetchThreadReplies(String threadId) async {
    _response = await _helper.get(
      ApiStringConstants.fetchAllThreadComments,
      querryParam: {"commentId": threadId},
      isPublic: false,
    );
    List<ThreadModel> threadReplies = [];
    _response.data.forEach((element) {
      threadReplies.add(ThreadModel.fromJson(element));
    });
    return threadReplies;
  }
}

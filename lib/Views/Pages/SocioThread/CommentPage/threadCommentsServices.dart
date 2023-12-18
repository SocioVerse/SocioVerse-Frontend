import 'package:socioverse/Models/threadModel.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Activity/activityModels.dart';
import 'package:socioverse/Views/Pages/SocioThread/CommentPage/threadCommentsModel.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/helpers/api_constants.dart';

class ThreadCommentServices{
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
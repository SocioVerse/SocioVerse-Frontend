import 'package:socioverse/Models/feedModel.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewFeed/Hashtag/hashtagModels.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/helpers/api_constants.dart';

class HashtagsServices {
  ApiHelper _helper = ApiHelper();
  ApiResponse _response = ApiResponse();
  Future<List<HashtagsSearchModel>> getHashtags(
      {required String hashtag}) async {
    _response = await _helper.get(
      ApiStringConstants.searchFeedsHashtags,
      querryParam: {'query': hashtag},
    );

    List<HashtagsSearchModel> hashtagsSearchModel = [];
    _response.data.forEach((element) {
      hashtagsSearchModel.add(HashtagsSearchModel.fromJson(element));
    });
    return hashtagsSearchModel;
  }

  Future<List<FeedThumbnail>> getHashtagsFeed(
      {required String tagId, required bool isRecent}) async {
    _response = await _helper.get(
      ApiStringConstants.fetchHashtagsFeed,
      querryParam: {'tagId': tagId, 'isRecent': isRecent.toString()},
    );

    List<FeedThumbnail> feedThumbnail = [];
    _response.data.forEach((element) {
      feedThumbnail.add(FeedThumbnail.fromJson(element));
    });
    return feedThumbnail;
  }
}

import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socioverse/Models/feedModel.dart';
import 'package:socioverse/Models/hashtagModels.dart';

class HashtagsServices {
  static ApiResponse _response = ApiResponse();
  static Future<List<HashtagsSearchModel>> getHashtags(
      {required String hashtag}) async {
    _response = await ApiHelper.get(
      ApiStringConstants.searchFeedsHashtags,
      querryParam: {'query': hashtag},
    );

    List<HashtagsSearchModel> hashtagsSearchModel = [];
    _response.data.forEach((element) {
      hashtagsSearchModel.add(HashtagsSearchModel.fromJson(element));
    });
    return hashtagsSearchModel;
  }

  static Future<List<FeedThumbnail>> getHashtagsFeed(
      {required String tagId, required bool isRecent}) async {
    _response = await ApiHelper.get(
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

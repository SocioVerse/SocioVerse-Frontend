class ApiStringConstants {
  static const String baseUrl = "192.168.75.238:4000";
  static const String refreshToken = "token/refresh";

  //Threads APIs
  static const String createThread = "threads/create-new-thread";
  static const String toogleLikeThread = "threads/toggle-thread-like";
  static const String toogleSaveThread = "threads/toggle-thread-save";
  static const String fetchAllThreadComments = "threads/read-comment-replies";
  static const String fetchAllSavedThreads = "threads/saved-threads";
  static const String fetchAllLikedThreads = "threads/liked-threads";
  static const String createComment = "threads/create-comment";
  static const String deleteThreads = "threads/delete-thread";
  static const String fetchThreadLikes = "threads/fetch-thread-likes";

  //Feed APIs
  static const String createFeed = "feeds/create-new-feed";
  static const String toogleLikeFeed = "feeds/toggle-feed-like";
  static const String toogleSaveFeed = "feeds/toggle-feed-save";
  static const String fetchAllFeedComments = "feeds/read-comment-replies";
  static const String fetchAllSavedFeeds = "feeds/saved-feeds";
  static const String fetchAllLikedFeeds = "feeds/liked-feeds";
  static const String fetchFeedsMentions = "feeds/fetch-mentioned-users";
  static const String createFeedComment = "feeds/create-feed-comment";
  static const String fetchFeedComments = "feeds/fetch-feed-comments";
  static const String fetchcommentReplies = "feeds/fetch-comment-replies"; //
  static const String toggleFeedCommentLike =
      "feeds/toggle-feed-commment-like"; //
  static const String fetchFeedLikes = "feeds/fetch-feed-likes";

  static const String getFeedById = "feeds/fetch-feed-by-id"; //
  static const String createCommentReply = "feeds/create-comment-reply"; //
  static const String deleteFeeds = "feeds/delete-feed"; //
  static const String deleteFeedComment = "feeds/delete-feed-commment"; //
  static const String searchFeedsLocation = "feeds/search-location";
  static const String searchFeedsHashtags = "feeds/search-hashtags";

  //Stories APIs
  static const String createStory = "stories/create-story";
  static const String readStory = "stories/read-story";
  static const String toogleStoryLike = "stories/toogle-story-like";
  static const String storySeen = "stories/story-seen";
  static const String deleteStory = "stories/delete-story";

  //Users APIs
  static const String isEmailExists = "users/verify-email-exists";
  static const String userSignUp = "users/signup";
  static const String userLogin = "users/login";
  static const String userLogout = "users/logout";
  static const String fetchUser = "users/fetch-user-details";
  static const String getFollowingThread = "users/fetch-following-threads";
  static const String getFollowingFeed = "users/fetch-following-feeds";
  static const String toogleFollowReq = "users/create-follow-request";
  static const String unFollow = "users/unfollow-user";
  static const String searchUser = "users/search-user";
  static const String searchUserByFace = "users/search-user-by-face";
  static const String searchFeedsByMetadata = "users/search-metadata";
  static const String searchLocation = "users/search-location";
  static const String searchHashtags = "users/search-hashtags";
  static const String fetchLatestFolloweRequests =
      "users/fetch-latest-follow-request";
  static const String updateProfile = "users/update-user-profile";
  static const String fetchAllFolloweRequests =
      "users/fetch-all-follow-request";
  static const String acceptFollowRequest = "users/confirm-follow-request";
  static const String rejectFollowRequest = "users/delete-follow-request";
  static const String fetchUserProfileDetails =
      "users/fetch-user-profile-details";
  static const String fetchFollowers = "users/fetch-followers";
  static const String fetchFollowing = "users/fetch-following";
  static const String addBio = "users/add-bio";
  static const String toogleRepostThread = "users/toogle-repost-thread";
  static const String fetchRepostThreads = "users/fetch-reposted-thread";
  static const String fetchAllStories = "users/fetch-all-stories";
  static const String fetchAllStorySeen = "users/fetch-all-stories-seens";
  static const String fetchUserFeeds = "users/fetch-user-feeds";
  static const String hideStory = "users/hide-story";
  static const String unhideStory = "users/unhide-story";

  //Chat APIs
  static const String getChatroomInfoByUser = "users/get-room-info-by-user";
  static const String fetchInbox = "users/all-recent-chats";

  //Hashtags APIs
  static const String fetchHashtagsFeed = "hashtags/fetch-hashtags-feeds";

  //Location APIs
  static const String fetchLocationFeed = "location/fetch-location-feeds";

  //Report APIs
  static const String createReport = "help/create-report";
}

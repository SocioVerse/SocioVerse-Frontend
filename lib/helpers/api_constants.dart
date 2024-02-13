class ApiStringConstants {
  static const String baseUrl = "192.168.29.71:4000";
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

  //Feed APIs
  static const String createFeed = "feeds/create-new-feed";
  static const String toogleLikeFeed = "feeds/toggle-feed-like";
  static const String toogleSaveFeed = "feeds/toggle-feed-save";
  static const String fetchAllFeedComments = "feeds/read-comment-replies";
  static const String fetchAllSavedFeeds = "feeds/saved-feeds";
  static const String fetchAllLikedFeeds = "feeds/liked-feeds";
  static const String createFeedComment = "feeds/create-comment";
  static const String deleteFeeds = "feeds/delete-feed";

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

  //Chat APIs
  static const String getChatroomInfoByUser = "users/get-room-info-by-user";
  static const String fetchInbox = "users/all-recent-chats";
}

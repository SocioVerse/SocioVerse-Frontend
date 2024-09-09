class ApiStringConstants {
  static const String baseUrl = "socioverse-backend-ygo9.onrender.com";
  static const String refreshToken = "token/refresh";

  //Threads APIs
  static const String createThread = "threads/create-new-thread";
  static const String getThreadById = "threads/read-thread";
  static const String toggleLikeThread = "threads/toggle-thread-like";
  static const String toggleSaveThread = "threads/toggle-thread-save";
  static const String fetchAllThreadComments = "threads/read-comment-replies";
  static const String fetchAllSavedThreads = "threads/saved-threads";
  static const String fetchAllLikedThreads = "threads/liked-threads";
  static const String createComment = "threads/create-comment";
  static const String deleteThreads = "threads/delete-thread";
  static const String fetchThreadLikes = "threads/fetch-thread-likes";
  static const String fetchTrendingThreads = "threads/fetch-trending-threads";

  //Feed APIs
  static const String createFeed = "feeds/create-new-feed";
  static const String toggleLikeFeed = "feeds/toggle-feed-like";
  static const String toggleSaveFeed = "feeds/toggle-feed-save";
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
  static const String fetchTrendingFeeds = "feeds/fetch-trending-feeds";
  static const String getFeedById = "feeds/fetch-feed-by-id"; //
  static const String createCommentReply = "feeds/create-comment-reply"; //
  static const String deleteFeeds = "feeds/delete-feed"; //
  static const String deleteFeedComment = "feeds/delete-feed-commment"; //
  static const String searchFeedsLocation = "feeds/search-location";
  static const String searchFeedsHashtags = "feeds/search-hashtags";
  static const String fetchCommentById = "feeds/fetch-comment-by-id"; //

  //Stories APIs
  static const String createStory = "stories/create-story";
  static const String readStory = "stories/read-story";
  static const String toggleStoryLike = "stories/toggle-story-like";
  static const String storySeen = "stories/story-seen";
  static const String deleteStory = "stories/delete-story";
  static const String getUserByStoryId = "stories/get-user-by-storyId";

  //Users APIs
  static const String isEmailExists = "users/verify-email-exists";
  static const String userSignUp = "users/signup";
  static const String userLogin = "users/login";
  static const String userLogout = "users/logout";
  static const String fetchUser = "users/fetch-user-details";
  static const String getFollowingThread = "users/fetch-following-threads";
  static const String getFollowingFeed = "users/fetch-following-feeds";
  static const String toggleFollowReq = "users/create-follow-request";
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
  static const String changePassword = "users/change-password";
  static const String fetchFollowers = "users/fetch-followers";
  static const String fetchFollowing = "users/fetch-following";
  static const String addBio = "users/add-bio";
  static const String toggleRepostThread = "users/toggle-repost-thread";
  static const String fetchRepostThreads = "users/fetch-reposted-thread";
  static const String fetchAllStories = "users/fetch-all-stories";
  static const String fetchAllStorySeen = "users/fetch-all-stories-seens";
  static const String fetchUserFeeds = "users/fetch-user-feeds";
  static const String hideStory = "users/hide-story";
  static const String unhideStory = "users/unhide-story";
  static const String getShareList = "users/get-recent-rooms-info";
  static const String fetchRoomId = "users/get-room-id";
  static const String getActivity = "users/get-activity";
  static const String fetchAllStoryHiddenUsers =
      "users/fetch-all-story-hidden-users";
  static const String removeFollower = "users/remove-follower";
  static const String generateOtp = "users/generate-otp";
  static const String verifyOtp = "users/verify-otp";

  //Chat APIs
  static const String getChatroomInfoByUser = "users/get-room-info-by-user";
  static const String createRoom = "users/create-room";
  static const String fetchInbox = "users/all-recent-chats";
  static const String unReadMessageCount = "users/unread-message-count";

  //Hashtags APIs
  static const String fetchHashtagsFeed = "hashtags/fetch-hashtags-feeds";

  //Location APIs
  static const String fetchLocationFeed = "location/fetch-location-feeds";

  //Report APIs
  static const String createReport = "help/create-report";

  // activity APIs
  static const String fetchFeedActivity = "activity/feeds";
  static const String fetchThreadActivity = "activity/threads";
  static const String fetchStoryLikesActivity = "activity/story-likes";
  static const String fetchMentionsActivity = "activity/mentions";
  static const String fetchThreadCommentsActivity = "activity/threads-comments";
  static const String fetchFeedCommentsActivity = "activity/feeds-comments";
}

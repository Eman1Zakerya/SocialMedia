abstract class SocialStates{}

class SocialInitialState extends SocialStates{}

class SocialGetUserLoadingState extends SocialStates{}

class SocialGetUserSuccessState extends SocialStates{}

class SocialGetUserErrorState extends SocialStates
{
  final String error;

  SocialGetUserErrorState(this.error);
}

class SocialGetAllUserLoadingState extends SocialStates{}

class SocialGetAllUserSuccessState extends SocialStates{}

class SocialGetAllUserErrorState extends SocialStates
{
  final String error;

  SocialGetAllUserErrorState(this.error);
}

class SocialGetPostsLoadingState extends SocialStates{}

class SocialGetPostsSuccessState extends SocialStates{}

class SocialGetPostsErrorState extends SocialStates
{
  final String error;

  SocialGetPostsErrorState(this.error);
}

class SocialSendMessagesSuccessState extends SocialStates{}

class SocialSendMessagesErrorState extends SocialStates
{
  final String error;

  SocialSendMessagesErrorState(this.error);
}

class SocialGetMessagesSuccessState extends SocialStates{}

class SocialGetMessagesErrorState extends SocialStates
{
  final String error;

  SocialGetMessagesErrorState(this.error);
}

class SocialLikePostsSuccessState extends SocialStates{}

class SocialLikePostsErrorState extends SocialStates
{
  final String error;

  SocialLikePostsErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates{}

class SocialNewPostState extends SocialStates{}

class SocialProfileImagePickedSuccessState extends SocialStates{}

class SocialProfileImagePickedErrorState extends SocialStates{}

class SocialProfileCoverPickedSuccessState extends SocialStates{}

class SocialProfileCoverPickedErrorState extends SocialStates{}

class SocialUploadProfileImageSuccessState extends SocialStates{}

class SocialUploadProfileImageErrorState extends SocialStates{}

class SocialUploadProfileCoverSuccessState extends SocialStates{}

class SocialUploadProfileCoverErrorState extends SocialStates{}

class SocialUserUpdateLoadingState extends SocialStates{}

class SocialUserUpdateErrorState extends SocialStates{}

//createPost
class SocialCreatePostLoadingState extends SocialStates{}

class SocialCreatePostSuccessState extends SocialStates{}

class SocialCreatePostErrorState extends SocialStates{}

class SocialPostImagePickedSuccessState extends SocialStates{}

class SocialPostImagePickedErrorState extends SocialStates{}

class SocialRemovePostImageState extends SocialStates{}

class AppChangeModeState extends SocialStates{}


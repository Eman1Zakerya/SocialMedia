
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/layout/cubit/states.dart';
import 'package:social_media/models/message_model.dart';
import 'package:social_media/models/post_model.dart';
import 'package:social_media/models/user_model.dart';
import 'package:social_media/modules/chats/chat_screen.dart';
import 'package:social_media/modules/feeds/feeds_screen.dart';
import 'package:social_media/modules/new_post/new_post_screen.dart';
import 'package:social_media/modules/settings/settings_screen.dart';
import 'package:social_media/modules/users/users_screen.dart';
import '../../network/local/cash_helper.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;




class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getUserData()async {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc( await CashHelper.getData(key: 'uid'))
        .get()
        .then((value) {
      print(value.data());
      userModel = UserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    })
        .catchError((error) {
      emit(SocialGetUserErrorState(error));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    const FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    MapsScreen(),
    SettingsScreen(),

  ];
  List<String> titles =[
    'Home',
    'Chats',
    'Posts',
    'Maps',
    'Settings',
  ];

  void changeBottomNav(int index)
  {
    if(index == 1) {
      getUsers();
    }
    if(index == 2) {
      emit(SocialNewPostState());
    } else
      {
        currentIndex = index;
        emit(SocialChangeBottomNavState());
      }

  }

   File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage()async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile !=null)
    {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    }else
    {
      print('No image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }



  File? coverImage;

  Future<void> getCoverImage()async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile !=null)
    {
      coverImage = File(pickedFile.path);
      emit(SocialProfileCoverPickedSuccessState());
    }else
    {
      print('No image selected');
      emit(SocialProfileCoverPickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,

})
  {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value){
          value.ref.getDownloadURL().then((value){
           // emit(SocialUploadProfileImageSuccessState());
            // print(value);
            // profileImageUrl = value;
            updateUser(name: name, phone: phone, bio: bio, image: value);

          }).catchError((error){
            emit(SocialUploadProfileImageErrorState());
          });
    })
        .catchError((error){
      emit(SocialUploadProfileImageErrorState());
    });
  }



  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
})
  {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value){
      value.ref.getDownloadURL().then((value){
        //emit(SocialUploadProfileCoverSuccessState());
        // print(value);
        // coverImageUrl = value;
        updateUser(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((error){
        emit(SocialUploadProfileCoverErrorState());
      });
    })
        .catchError((error){
      emit(SocialUploadProfileCoverErrorState());
    });
  }

  File? postImage;

  Future<void> getPostImage()async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile !=null)
    {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    }else
    {
      print('No image selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage()
  {
    postImage =null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  })
  {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value){
      value.ref.getDownloadURL().then((value)
      {
        createPost(
            dateTime: dateTime,
            text: text,
            postImage: value
        );

      }).catchError((error){
        emit(SocialCreatePostErrorState());
      });
    })
        .catchError((error){
      emit(SocialCreatePostErrorState());
    });
  }



  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  })
  {
    emit(SocialCreatePostLoadingState());

    PostModel model1 = PostModel(
      name: userModel?.name,
      uid: userModel?.uid,
      image: userModel?.image,
      dateTime: dateTime,
      text: text,
      postImage: postImage??'',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model1.toMap())
        .then((value)
    {
       emit(SocialCreatePostSuccessState());
    })
        .catchError((error){
      emit(SocialCreatePostErrorState());
    });
  }




  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover ,
    String? image ,
  })
  {
    UserModel model = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel?.email,
      uid: userModel?.uid,
      cover: cover?? userModel?.cover,
      image: image?? userModel?.image,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uid)
        .update(model.toMap())
        .then((value) {
      //عشان بعد منرفع بن get تانى
      getUserData();
    })
        .catchError((error){
      emit(SocialUserUpdateErrorState());
    });
  }

 List<PostModel> posts =[];
  List<String> postsId =[];
  List<int> likes =[];

  void getPosts()
  {
     FirebaseFirestore.instance
         .collection('posts')
         .get()
         .then((value) {
           value.docs.forEach((element) {
             element.reference
                 .collection('likes')
                 .get().then((value)
             {
               //print(postsId);
               likes.add(value.docs.length);
               postsId.add(element.id);
               posts.add(PostModel.fromJson(element.data()));
             });
                 //.catchError((error){});

           });
           emit(SocialGetPostsSuccessState());
     })
         .catchError((error){
           emit(SocialGetPostsErrorState(error));
     });
  }

  void likePost(String postId)
  {
     FirebaseFirestore.instance
         .collection('posts')
         .doc(postId)
         .collection('likes')
         .doc(userModel?.uid)
         .set({
       'like':true,
     })
         .then((value){
           emit(SocialLikePostsSuccessState());
     })
         .catchError((error){
           emit(SocialLikePostsErrorState(error));
     });
  }


  List<UserModel> users =[];
  void getUsers()
  {
    if(users.isEmpty) {
      FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) {
      value.docs.forEach((element) {
          if(element.data()['uid']!=userModel?.uid)
          users.add(UserModel.fromJson(element.data()));
        });

      emit(SocialGetAllUserSuccessState());
    })
        .catchError((error){
      emit(SocialGetAllUserErrorState(error));
    });
    }
  }


  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  })
  {
    MessageModel model = MessageModel(
      text: text,
      senderId: userModel!.uid,
      receiverId: receiverId,
      dateTime: dateTime,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value){
          emit(SocialSendMessagesSuccessState());
    })
        .catchError((error){
          emit(SocialSendMessagesErrorState(error));
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uid)
        .collection('messages')
        .add(model.toMap())
        .then((value){
      emit(SocialGetMessagesSuccessState());
    })
        .catchError((error){
      emit(SocialGetMessagesErrorState(error));
    });
  }

  List<MessageModel>messages =[];
  void getMessages({required String receiverId,})
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event)
    {
          messages =[];
          event.docs.forEach((element)
          {
               messages.add(MessageModel.fromJson(element.data()));
          });
          emit(SocialGetMessagesSuccessState());
    });
  }




  bool isDark = true;

  void changeAppMode({bool? fromShared})
  {
    if(fromShared != null)
    {
      isDark = fromShared;
      emit(AppChangeModeState());
    }

    else
    {
      isDark = !isDark;

      CashHelper.putBoolean(key: 'isDark',value: isDark).then((value)
      {

        emit(AppChangeModeState());
      });

    }



  }

}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/models/user_model.dart';
import 'package:social_media/modules/register/cubit/states.dart';

import 'package:firebase_auth/firebase_auth.dart';



class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit( ) : super(SocialRegisterInitialState());
  static SocialRegisterCubit get(context) =>BlocProvider.of(context);
 // late SocialLoginModel loginModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  })
  {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      userCreate(name: name,
          email: email,
          phone: phone,
          uid: value.user!.uid);
      // emit(SocialRegisterSuccessState());
    }).catchError((error){
      emit(SocialRegisterErrorState(error));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uid,
  })
  {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uid: uid,
      bio: 'write your bio...',
      image: 'https://i.pinimg.com/originals/3e/6b/00/3e6b00201d57d69abf871d162b457897.jpg',
      cover: 'https://th.bing.com/th/id/R.0cc6b49f44675f9bfaf27e26376d0824?rik=z41sKvLQnOi11g&riu=http%3a%2f%2f4.bp.blogspot.com%2f-JW8uYNFroVk%2fUnfQFIkvrBI%2fAAAAAAAAB6Y%2fbQFK2PxFHiE%2fs1600%2fcute%2bbaby%2bgirls%2bwallpapers-5.jpg&ehk=sSfeSe4OlfugGbfnEBJdW%2fw8pa8WxyC%2fcdvljTtnAM0%3d&risl=&pid=ImgRaw&r=0',
      isEmailVerified: false,
    );
    FirebaseFirestore
        .instance
        .collection('users')
        .doc(uid)
        .set(model.toMap()).then((value) {
          emit(SocialCreateUserSuccessState());
    }).catchError((error){
      emit(SocialCreateUserErrorState(error));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  
  void changePasswordVisibility()
  {
     isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterChangePasswordVisibilityState());
   
  }





}
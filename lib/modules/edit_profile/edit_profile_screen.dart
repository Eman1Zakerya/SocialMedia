
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/layout/cubit/cubit.dart';
import 'package:social_media/layout/cubit/states.dart';
import 'package:social_media/shared/components/components.dart';
import 'package:social_media/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
var nameController = TextEditingController();
var phoneController = TextEditingController();
var bioController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (contextn, state){},
      builder: (contextn, state)
      {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        nameController.text = userModel!.name!;
        phoneController.text = userModel.phone!;
        bioController.text = userModel.bio!;
        return Scaffold(
          appBar: defaultAppBar(
              context: context,
              title: 'Edit Profile',
              actions: [
                defaultTextButton(
                  function:(){
                    SocialCubit.get(context).updateUser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text);
                  } ,
                  text:'Update' ,
                ),
                SizedBox(width: 15,)
              ],
          ),
          body:Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if(state is SocialUserUpdateLoadingState)
                  LinearProgressIndicator(),
                  if(state is SocialUserUpdateLoadingState)
                  SizedBox(height: 10,),
                  Container(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140,
                                width: double.infinity,
                                decoration:  BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4),
                                        topRight:  Radius.circular(4)
                                    ),
                                    image: DecorationImage(
                                        image:coverImage==null ?
                                        NetworkImage('${userModel.cover}') as ImageProvider
                                            :FileImage(coverImage),
                                        fit: BoxFit.cover
                                    )
                                ),

                              ),
                              IconButton(
                                  onPressed: (){
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon: CircleAvatar(
                                    radius: 20,
                                      child: const Icon(
                                          IconBroken.Camera,
                                        size: 16,
                                      )),
                              ),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          radius: 64,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          child:  Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                profileImage ==null ?
                                NetworkImage(
                                  '${userModel.image}',) as ImageProvider
                                    : FileImage(profileImage )
                              ),
                              IconButton(
                                onPressed: (){
                                  SocialCubit.get(context).getProfileImage();
                                },
                                icon: CircleAvatar(
                                    radius: 20,
                                    child: const Icon(
                                      IconBroken.Camera,
                                      size: 16,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                 
                  SizedBox(height: 20,),
                  if(SocialCubit.get(context).profileImage !=null || SocialCubit.get(context).coverImage !=null)
                  Row(
                    children: [
                      if(SocialCubit.get(context).profileImage !=null)
                      Expanded(
                        child: Column(
                          children: [
                            defaultButton(
                                function: (){
                                  SocialCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text);
                                },
                                text: 'upload profile'
                            ),
                            if(state is SocialUserUpdateLoadingState)
                            SizedBox(height: 5,),
                            if(state is SocialUserUpdateLoadingState)
                            LinearProgressIndicator(),

                          ],
                        ),
                      ),
                      SizedBox(width: 5,),
                      if(SocialCubit.get(context).coverImage !=null)
                      Expanded(
                        child: Column(
                          children: [
                            defaultButton(
                                function: (){
                                  SocialCubit.get(context).uploadCoverImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text);
                                },
                                text: 'upload cover '
                            ),
                            if(state is SocialUserUpdateLoadingState)
                            SizedBox(height: 5,),
                            if(state is SocialUserUpdateLoadingState)
                            LinearProgressIndicator(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 60,
                    child: defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        lable: 'name',
                        prefix: IconBroken.User
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 60,
                    child: defaultFormField(
                        controller: bioController,
                        type: TextInputType.text,
                        lable: 'Bio',
                        prefix: IconBroken.Info_Circle
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 60,
                    child: defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        lable: 'phone',
                        prefix: IconBroken.Call
                    ),
                  ),
                ],
              ),
            ),
          ) ,
        );
      } ,

    );
  }
}
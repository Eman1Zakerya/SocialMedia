import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/layout/cubit/cubit.dart';
import 'package:social_media/layout/cubit/states.dart';
import 'package:social_media/modules/edit_profile/edit_profile_screen.dart';
import 'package:social_media/shared/components/components.dart';
import 'package:social_media/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit , SocialStates>(
      listener: (context , state){},
      builder: (context , state)
      {
        var userModel = SocialCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 190,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 140,
                        width: double.infinity,
                        decoration:  BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight:  Radius.circular(4)
                            ),
                            image: DecorationImage(
                                image: NetworkImage('${userModel?.cover}'),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child:  CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            '${userModel?.image}',

                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5,),
              Text('${userModel?.name}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(height: 5,),
              Text('${userModel?.bio}',
                style: Theme.of(context).textTheme.caption!.copyWith(
                  fontSize: 14,
                    fontWeight: FontWeight.bold
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('265',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            const SizedBox(height: 5,),
                            Text('Photos',
                              style: Theme.of(context).textTheme.caption!.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold
                              ),
                            ),

                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('100',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            const SizedBox(height: 5,),
                            Text('posts',
                              style: Theme.of(context).textTheme.caption!.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold
                              ),
                            ),

                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('10k',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            const SizedBox(height: 5,),
                            Text('Followers',
                              style: Theme.of(context).textTheme.caption!.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold
                              ),
                            ),

                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('64',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            const SizedBox(height: 5,),
                            Text('Followings',
                              style: Theme.of(context).textTheme.caption!.copyWith(
                                  fontSize: 13,
                                fontWeight: FontWeight.bold
                              ),
                            ),

                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: (){},
                      child: Text('Add Photos'),
                    )
                  ),
                  SizedBox(width: 10,),
                  OutlinedButton(
                    onPressed: (){
                      navigateTo(context, EditProfileScreen());
                    },
                    child: Icon(
                      IconBroken.Edit,
                      size: 16,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  OutlinedButton(onPressed: (){
                    FirebaseMessaging.instance.subscribeToTopic('announcements');
                  },
                      child: const Text('Subscribe')
                  ),
                  SizedBox(width: 20,),
                  OutlinedButton(onPressed: ()
                  {
                    FirebaseMessaging.instance.unsubscribeFromTopic('announcements');
                  },
                      child: const Text('UnSubscribe')
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
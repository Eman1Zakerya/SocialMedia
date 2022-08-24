
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/layout/cubit/cubit.dart';
import 'package:social_media/layout/cubit/states.dart';
import 'package:social_media/modules/new_post/new_post_screen.dart';
import 'package:social_media/shared/components/components.dart';
import 'package:social_media/shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: ((context, state) {
        if(state is SocialNewPostState)
          {
            navigateTo(context, NewPostScreen());
          }
      }),
      builder:((context, state) {
        var cubit = SocialCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(onPressed: (){},
                  icon:Icon( IconBroken.Notification)),
              IconButton(onPressed: (){},
                  icon:Icon( IconBroken.Search)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap:(index)
            {
               cubit.changeBottomNav(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat),
                label: 'Chats'
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper_Upload),
                  label: 'Post'
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Location),
                label: 'users'
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting),
                label: 'settings'
              ),
            ],
          ),
        );
      }),

    );
  }
}

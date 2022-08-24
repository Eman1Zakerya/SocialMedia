import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/layout/cubit/cubit.dart';
import 'package:social_media/layout/cubit/states.dart';
import 'package:social_media/shared/components/components.dart';
import 'package:social_media/shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state){},
      builder:(context, state)
      {
        return Scaffold(
          appBar: defaultAppBar(
              context: context,
              title: 'Create Post',
              actions:[
                defaultTextButton(
                    function: (){
                      var now = DateTime.now();
                      if(SocialCubit.get(context).postImage==null)
                        {
                          SocialCubit.get(context).createPost(
                              dateTime: now.toString(),
                              text: textController.text,
                          );
                        }else
                          {
                            SocialCubit.get(context).uploadPostImage(
                                dateTime: now.toString(),
                                text: textController.text
                            );
                          }
                    },
                    text: 'Post')
              ]
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)

                  SizedBox(height: 10,),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-photo/full-shot-travel-concept-with-landmarks_23-2149153258.jpg?3&t=st=1657056465~exp=1657057065~hmac=ec66f193a4dbe902d96f5ec0d7c4c9b51f45d88a4a001d6392faac75a7f3780e&w=900'
                      ),
                    ),
                    SizedBox(width: 15,),
                    Expanded(
                      child: Text('Eman Zakareya',
                        style:TextStyle(height:1.3,fontSize: 15) ,),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: 'what is on your mind...',
                      border: InputBorder.none
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                if(SocialCubit.get(context).postImage !=null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 140,
                      width: double.infinity,
                      decoration:  BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                              image:FileImage(SocialCubit.get(context).postImage!),
                              fit: BoxFit.cover
                          )
                      ),

                    ),
                    IconButton(
                      onPressed: ()
                      {
                          SocialCubit.get(context).removePostImage();
                      },
                      icon: CircleAvatar(
                          radius: 20,
                          child: const Icon(
                            Icons.close,
                            size: 16,
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: (){
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconBroken.Image),
                              SizedBox(width: 5,),
                              Text('Add Photo')
                            ],
                          )
                      ),
                    ),
                    Expanded(
                      child: TextButton(onPressed: (){},
                          child:Text('# Tags'),
                          )
                      ),

                  ],
                )
              ],
            ),
          ),
        );
      } ,

    );
  }
}

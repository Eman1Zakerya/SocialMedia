
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/layout/cubit/cubit.dart';
import 'package:social_media/layout/cubit/states.dart';
import 'package:social_media/models/post_model.dart';
import 'package:social_media/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit
              .get(context)
              .posts.isNotEmpty ,//&& SocialCubit.get(context).userModel !=null,
          builder: (context) =>
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 5,
                      margin: const EdgeInsets.all(8),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Image(
                            image: NetworkImage(
                                'https://4.bp.blogspot.com/-Rh8j6N0K-Nc/Uq6MDfMCgPI/AAAAAAAACMU/piuSyeBDYRM/s1600/1280_jdsj018.jpg'),
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                          ),
                          Text('communicate with friends',
                            style: Theme
                                .of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                color: Colors.white
                            ),)
                        ],
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          buildPostItem(SocialCubit
                              .get(context)
                              .posts[index], context,index),
                      separatorBuilder: (context, index) =>
                      const SizedBox(height: 8,),
                      itemCount: SocialCubit
                          .get(context)
                          .posts
                          .length,
                    ),
                    const SizedBox(height: 8,),


                  ],
                ),
              ),
          fallback: (context) =>
          const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

}
  Widget buildPostItem( PostModel model,context,index){
   return Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5,
    child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        '${model.image}'
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('${model.name}',
                                style:TextStyle(height:1.3,fontSize: 15) ,),
                              SizedBox(width: 5,),
                              Icon(Icons.check_circle,
                                color: Colors.blue,
                                size: 16,
                              ),
                            ],
                          ),
                          Text('${model.dateTime}',
                            style:Theme.of(context).textTheme.caption!.copyWith(
                                height: 1.4,
                                fontSize: 13
                            ) ,)
                        ],
                      )
                  ),
                  SizedBox(width: 16,),
                  IconButton(
                      onPressed: (){},
                      icon:Icon(Icons.more_horiz,
                        size: 16,
                      )
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
              Text('${model.text}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 10,top: 5),
              //   child: Container(
              //     width: double.infinity,
              //     child: Wrap(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 6),
              //           child: Container(
              //             height: 25,
              //             child: MaterialButton(
              //               minWidth: 1,
              //               padding: EdgeInsets.zero,
              //               onPressed: (){},
              //               child: Text('#software',
              //                   style: Theme.of(context).textTheme.caption!.copyWith(
              //                       color: Colors.blue,fontSize: 14
              //                   )
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 6),
              //           child: Container(
              //             height: 25,
              //             child: MaterialButton(
              //               minWidth: 1,
              //               padding: EdgeInsets.zero,
              //               onPressed: (){},
              //               child: Text('#flutter',
              //                   style: Theme.of(context).textTheme.caption!.copyWith(
              //                       color: Colors.blue,fontSize: 14
              //                   )
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              if(model.postImage !='')
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 15),
                  child: Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                            image: NetworkImage('${model.postImage}'),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Heart,
                                size: 16,
                                color: Colors.red,
                              ),
                              SizedBox(width: 5,),
                              Text('${SocialCubit.get(context).likes[index]}',
                                style: Theme.of(context).textTheme.caption!.copyWith(
                                    fontSize: 13
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                IconBroken.Chat,
                                size: 16,
                                color: Colors.amber,
                              ),
                              SizedBox(width: 5,),
                              Text('0 comment',
                                style: Theme.of(context).textTheme.caption!.copyWith(
                                    fontSize: 13
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: (){},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundImage: NetworkImage(
                                  '${SocialCubit.get(context).userModel?.image}'
                              ),
                            ),
                            SizedBox(width: 15,),
                            Text('Write a comment......',
                              style:Theme.of(context).textTheme.caption!.copyWith(
                                  fontSize: 13
                              ) ,),
                          ]
                      ),
                      onTap: (){},
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          size: 16,
                          color: Colors.red,
                        ),
                        SizedBox(width: 5,),
                        Text('Like',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              fontSize: 13
                          ),
                        )
                      ],
                    ),
                    onTap: ()
                    {
                      SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                    },
                  ),
                ],
              )


            ],
        ),
    ),
   );
  }

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/layout/cubit/cubit.dart';
import 'package:social_media/models/message_model.dart';
import 'package:social_media/models/user_model.dart';
import 'package:social_media/shared/styles/colors.dart';
import 'package:social_media/shared/styles/icon_broken.dart';

import '../layout/cubit/states.dart';

class ChatDetailsScreen extends StatelessWidget {
   ChatDetailsScreen({ required this.userModel});
  UserModel userModel;
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context)
      {
        SocialCubit.get(context).getMessages(receiverId: userModel.uid!);
         return BlocConsumer<SocialCubit,SocialStates>(
           listener: (context, state){},
           builder:(context, state){
             return  Scaffold(
               appBar: AppBar(
                 titleSpacing: 0,
                 title: Row(
                   children: [
                     CircleAvatar(
                       radius: 20,
                       backgroundImage: NetworkImage('${userModel.image}'),
                     ),
                     SizedBox(width: 15,),
                     Text('${userModel.name}')
                   ],
                 ),
               ),
               body: ConditionalBuilder(
                 condition:SocialCubit.get(context).messages.isNotEmpty ,
                 builder: (context)=>Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: Column(
                     children: [
                       Expanded(
                         child: ListView.separated(
                           physics: const BouncingScrollPhysics(),
                             itemBuilder: (context, index)
                             {
                               var message = SocialCubit.get(context).messages[index];
                               if(SocialCubit.get(context).userModel?.uid == message.senderId)
                               {
                                 return buildMyMessage(message);
                               }else {
                                 return buildMessage(message);
                               }
                             },
                             separatorBuilder:(context, index)=>SizedBox(height: 15,) ,
                             itemCount: SocialCubit.get(context).messages.length
                         ),
                       ),
                       Container(
                         decoration: BoxDecoration(
                           border: Border.all(
                               color: Colors.grey,
                               width: 1
                           ),
                           borderRadius: BorderRadius.circular(15),
                         ),
                         clipBehavior: Clip.antiAliasWithSaveLayer,
                         child: Row(
                           children: [
                             Expanded(
                               child: TextFormField(
                                 controller:messageController ,
                                 decoration: InputDecoration(
                                     border: InputBorder.none,
                                     hintText: 'Type your message here....'
                                 ),
                               ),
                             ),
                             MaterialButton(
                               onPressed: (){
                                 SocialCubit.get(context).sendMessage(
                                   receiverId: userModel.uid!,
                                   dateTime: DateTime.now().toString(),
                                   text:messageController.text,
                                 );
                               },
                               minWidth: 1,
                               child: Icon(IconBroken.Send,size: 30,color: Colors.teal,),
                             )
                           ],
                         ),
                       )
                     ],
                   ),
                 ),
                 fallback:(context)=>const Center(child: CircularProgressIndicator(),) ,
               ),
             );
           } ,

         );
      },

    );
  }
  Widget buildMessage(MessageModel model)=> Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10),
            topEnd:Radius.circular(10) ,
            topStart: Radius.circular(10),

          )
      ),
      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
      child: Text('${model.text}'),
    ),
  );

   Widget buildMyMessage(MessageModel model)=>Align(
     alignment: AlignmentDirectional.centerEnd,
     child: Container(
       decoration: BoxDecoration(
           color: defaultColor.withOpacity(0.2),
           borderRadius: BorderRadiusDirectional.only(
             bottomStart: Radius.circular(10),
             topStart:Radius.circular(10) ,
             topEnd: Radius.circular(10),

           )
       ),
       padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
       child: Text('${model.text}'),
     ),
   );

}

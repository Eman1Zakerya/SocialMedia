import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_media/shared/styles/icon_broken.dart';
import '../../network/local/cash_helper.dart';
import '../styles/colors.dart';

void navigateTo(BuildContext context, Widget widget)=> Navigator.push(context, 
MaterialPageRoute(builder: (context)=>widget),
);

void navigateAndFinish( BuildContext context, Widget widget)=>Navigator.pushAndRemoveUntil(
  context, 
 MaterialPageRoute(builder: (context)=>widget), 
  ( Route <dynamic>route) => false
  );


Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
void Function(String)?onSubmit,
 void Function(String)? onChanged,
  VoidCallback? suffixpressed,
 
 VoidCallback? onTap,
 
  required String lable,
  required IconData prefix,
  IconData? suffix,
  bool isClicable = true,
  bool isPassword = false,
})=>TextFormField(
  controller: controller,
  keyboardType: type,
  onFieldSubmitted:onSubmit,
  onChanged: onChanged,
  obscureText: isPassword,
  enabled: isClicable,
  onTap:onTap ,
    validator: (data) {
        if (data!.isEmpty) {
          return 'field is required';
        }
      },
  decoration: InputDecoration(
    labelText: lable,
    suffix:IconButton(onPressed:suffixpressed ,icon:Icon(suffix) ,) ,
    prefixIcon:Icon(prefix) ,
    border: OutlineInputBorder(),
    
  ),
);


Widget defaultButton({
        double  width= double.infinity,
        required VoidCallback? function,
       //Color background =defaultColor,
        bool isUpperCase =true,
          double radius =3.0,
        required String text,


      })=>Container(
                  width: width,
                  height:50,
                  color: defaultColor,
                  child: MaterialButton(
                    onPressed: function,
                    child: Text(
                       isUpperCase ? text.toUpperCase() :text,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );

Widget defaultTextButton({
                   required VoidCallback? function,
                    required String text,
        
                })=> TextButton(onPressed: function, 
                    child: Text(text.toUpperCase()));


      void showToast({
        required String text,
        required ToastState state,
      }) => Fluttertoast.showToast(
               msg: text,
               toastLength: Toast.LENGTH_LONG,
               gravity: ToastGravity.BOTTOM,
               timeInSecForIosWeb: 5,
               backgroundColor: chooseToastColor(state),
               textColor: Colors.white,
               fontSize: 16.0
    ); 
    enum ToastState{SUCCESS,ERROR,WARNING}  

    Color chooseToastColor(ToastState state)
    {
      Color color;
      switch(state)
      {

        case ToastState.SUCCESS:
        color = Colors.green;
          break;
        case ToastState.ERROR:
         color = Colors.red;
          break;
        case ToastState.WARNING:
        color = Colors.amber;
          break;
      }
      return color;
    }


PreferredSizeWidget defaultAppBar({
      required BuildContext context,
       String? title,
       List<Widget>? actions,
})=>AppBar(
       leading: IconButton
         (onPressed: ()
       {
           Navigator.pop(context);
       },
           icon: Icon(IconBroken.Arrow___Left_2)
       ),
       titleSpacing: 5,
       title: Text(title!),
       actions: actions,
     );

    // void signOut(BuildContext  context)
    // {
    //    CashHelper.removData(key: 'token').then((value) {
    //     print(value);
    //          if(value!){
    //            // navigateAndFinish(context, ShopLoginScreen());
    //          }
    //        });
    // }

    void printFullText(String text)
    {
       final pattern = RegExp('.{1,800}');
       pattern.allMatches(text).forEach((match)=>print(match.group(0)));
    }

    Widget myDivider()=>Padding(
          padding: const EdgeInsetsDirectional.only(start: 20),
          child: Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[300],
          ),
              );



import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/layout/social_layout_screen.dart';
import 'package:social_media/network/local/cash_helper.dart';

import '../../shared/components/components.dart';
import '../register/register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialLoginScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return   BlocConsumer<SocialLoginCubit,SocialLoginStates>(
      listener:(context , state)
      {
        if(state is SocialLoginErrorState)
          {
            showToast(text: state.error, state: ToastState.ERROR);
          }

        if(state is SocialLoginSuccessState)
          {
            CashHelper.saveData(
                key: 'uid',
                value: state.uid,
            ).then((value) {
              navigateAndFinish(context, SocialLayout());
            });
          }
      },
      builder:(context , state)
      {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black
                        ),
                      ),
                      Text(
                        'Login now to communicate with friends',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey
                        ),
                      ),
                      SizedBox(height: 30,),
                      defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          lable: 'Email Address',
                          prefix: Icons.email_outlined
                      ),
                      SizedBox(height: 15,),
                      defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,

                          lable: 'Password',
                          onSubmit: (value){
                            if(formKey.currentState!.validate());
                            {
                              SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }

                          },
                          isPassword:  SocialLoginCubit.get(context).isPassword,
                          suffix: SocialLoginCubit.get(context).suffix ,
                          suffixpressed: (){
                            SocialLoginCubit.get(context).changePasswordVisibility();

                          },
                          prefix: Icons.lock_outline
                      ),
                      SizedBox(height: 30,),

                      ConditionalBuilder(
                        condition: state is! SocialLoginLoadingState,
                        builder: (context)=>defaultButton(
                            function: (){
                              if(formKey.currentState!.validate());
                              {
                                SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);

                                navigateTo(context,SocialLayout() );
                              }

                            },
                            text:'login',
                            isUpperCase: true
                        ),
                        fallback:(context)=>Center(child: CircularProgressIndicator()),

                      ),
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account?'),
                          defaultTextButton(
                              function:(){
                                navigateTo(context,RegisterScreen() );
                              },
                              text: 'Register'
                          ),



                        ],


                      )

                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      } ,

    );;
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/layout/social_layout_screen.dart';
import 'package:social_media/modules/login/social_login_screen.dart';
import 'package:social_media/shared/components/components.dart';
import 'package:social_media/shared/styles/thems.dart';
import 'layout/cubit/cubit.dart';
import 'modules/login/cubit/cubit.dart';
import 'modules/register/cubit/cubit.dart';
import 'network/local/cash_helper.dart';
import 'shared/styles/bloc_observe.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('onBackgroundMessage');
  print(message.data.toString());
  showToast(text: 'onBackgroundMessage', state: ToastState.SUCCESS);

}

void main()async {
  //بيتاكد ان كل حاجة في الميثود خلصت بعدين يفتح الاب
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp( );

var token = FirebaseMessaging.instance.getToken();
print(token);

FirebaseMessaging.onMessage.listen((event) {
  print(event.data.toString());
  showToast(text: 'onMessage', state: ToastState.SUCCESS);
});
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToast(text: 'onMessage opened app', state: ToastState.SUCCESS);

  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  BlocOverrides.runZoned(
        () {
      // Use blocs...

    },
    blocObserver: MyBlocObserver(),

  );
  // DioHelper.init();
  await  CashHelper.init();
  //SharedPreferences.getInstance();

 runApp(MyApp() );


}

class MyApp extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    return
    MultiBlocProvider(
      providers: [
        BlocProvider<SocialLoginCubit>(create:(BuildContext context)=>SocialLoginCubit()),
        BlocProvider<SocialRegisterCubit>(create:(BuildContext context)=>SocialRegisterCubit()),
        BlocProvider<SocialCubit>(create:(BuildContext context)=>SocialCubit()..getUserData()..getPosts())
      ],


        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,


            home:  CashHelper.getData(key: 'uid').toString().isEmpty?SocialLoginScreen():const SocialLayout(),
            //SocialLoginScreen()
               //startWidget
        )

    );

  }
}

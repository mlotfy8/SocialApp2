import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Cubit/get_fire_data_cubit.dart';
import 'Screenes/LoginPage.dart';
import 'Screenes/main Home.dart';
import 'Screenes/myprofile.dart';
import 'Screenes/singup.dart';
import 'firebase_options.dart';

var user = FirebaseAuth.instance.currentUser;
SharedPreferences? name;
SharedPreferences? mood;
SharedPreferences? ProfileUrl;
SharedPreferences? BackUrl;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  name = await SharedPreferences.getInstance();
  mood = await SharedPreferences.getInstance();
  ProfileUrl = await SharedPreferences.getInstance();
  BackUrl = await SharedPreferences.getInstance();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => GetFireDataCubit(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: user == null ? LoginPage() : MainHome(),
        //   theme: ThemeData(fontFamily: 'NotoSerif'),
        routes: {
          'home': (context) => MainHome(),
          'singup': (context) => singup(),
          'login': (context) => LoginPage(),
          'myprofile': (context) => myprofile()
        },
      ),
    );
  }
}

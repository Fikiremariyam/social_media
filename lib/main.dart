import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media/views/Home/HomePage.dart';
import 'package:social_media/views/Home/utils/config.dart';
import 'package:social_media/views/auth/login.dart';
import 'package:social_media/views/auth/signup.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
void main()  async {
  print("started zego cloud +++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
  await ZIMKit().init(
    appID: appId ,
    appSign: appsign ,

    );
    print("finshed starting zego  +++++++++++++++++++++++++++++++++++++ ");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:  false,
      title: 'TeraFlow',
      theme: ThemeData(
        fontFamily: GoogleFonts.ibmPlexSans().fontFamily,

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,

      ),
      home: FirebaseAuth.instance.currentUser == null ? const LogInPage(): const Homepage(),
    );
  }
}

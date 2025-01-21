import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_media/views/Home/LandingPage.dart';
import 'package:social_media/views/Home/searchPage.dart';
import 'package:social_media/views/Home/utils/image_post.dart';
import 'package:social_media/views/Home/utils/text_post.dart';
import 'package:social_media/views/auth/login.dart';
import 'package:social_media/views/Home/utils/chatList.dart';
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}


class _HomepageState extends State<Homepage> {
  TextEditingController posttext =  TextEditingController();
  int index = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (i){
          setState(() {
            index=i;
          });
          

        },
        currentIndex: index,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.chat),label: "chat"),
          BottomNavigationBarItem(icon: Icon(Icons.live_tv),label: "live")


        ]),
      body:IndexedStack(
        index: index,
        children: [
          Landingpage(),
          chatList(),
          Container()

        ],
      ) 
    );
    }
}
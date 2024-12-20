import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_media/views/Home/searchPage.dart';
import 'package:social_media/views/auth/login.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar( 
                    title: Text("Homepage"),
                    flexibleSpace: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.purple],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                    actions: [IconButton(onPressed: (){
                                    Navigator.of(context).push(MaterialPageRoute (
                                    builder: (context) => const Searchpage()
                                    ),
                                    );//navigator

                                    },  
                                    icon: Icon(Icons.search))
                                    ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              onTap: () async{
                            FirebaseAuth.instance.signOut(); 
                            Navigator.of(context).pushAndRemoveUntil(
                                                                  MaterialPageRoute(builder: (context)=> const LogInPage()),(route)=> false);
                
                              },
              title: Text(
                "Sign Out"
              ),
            )
          ],
        ),
      ),
    );
    }
}
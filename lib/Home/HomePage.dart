import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_media/views/login.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("Homepage")),
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
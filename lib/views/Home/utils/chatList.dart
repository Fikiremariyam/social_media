import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/views/Home/utils/chatPage.dart';
class chatList extends StatefulWidget {
  const chatList({super.key});

  @override
  State<chatList> createState() => _chatListState();
}

class _chatListState extends State<chatList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("your Chats"),),
      body: FutureBuilder(
        future:  FirebaseFirestore.instance.collection('chats').where('users',arrayContains: FirebaseAuth.instance.currentUser!.email).get() , 
        builder: (context,snapshot){
          if (snapshot.hasData){
            if (snapshot.data!.docs.isEmpty ?? true){
              return Text("no chat yets");
            }
            return ListView.builder(
              itemCount: snapshot.data?.docs.length ?? 0 ,
              itemBuilder:(context, index){
                DocumentSnapshot doc = snapshot.data!.docs[index];
                return ListTile(

                  title : Text( doc['users'][1] )
                  ,
                  subtitle: Text(doc['recent_text']),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Chatpage(doc: doc)));

                  },
                  trailing: Icon(

                    Icons.arrow_forward,
                    
                  ),
                  );
                
              });
          }else{
           return  CircularProgressIndicator();
          }
          
          
         
        }
        ),

    );
  }
} 
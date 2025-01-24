import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/views/Home/utils/messagebox.dart';

class Chatpage extends StatefulWidget {
  final DocumentSnapshot doc;

  const Chatpage({
    super.key,
    required this.doc
  });

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  TextEditingController message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title: Text("chatting page "),),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
            stream: widget.doc.reference.collection('messages').orderBy('time').snapshots(), 
          builder: (context, snapshot){
            if(snapshot.hasData){
              if (snapshot.data?.docs.isEmpty ?? true){
                return Text("No messages yet!");

              }
             return ListView.builder(
                padding: EdgeInsets.all(15.0),
                    itemCount: snapshot.data?.docs.length ?? 0 ,
                    itemBuilder: (context, index){
                      DocumentSnapshot msg =snapshot.data!.docs[index];
                    return
                      TelegramMessageBubble(message: msg['message'].toString(), isSentByMe: msg['uid']== FirebaseAuth.instance.currentUser!.email) ;
                      
               
                    }
             );
                
                


            }else{
              return CircularProgressIndicator();
            }

          }))
          ,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: 
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                    controller:  message,
                    decoration: InputDecoration(
                      labelText: "type your message",
                
                    ),
                    )
                    ),
                  ElevatedButton(
                    onPressed: () async{
                      await widget.doc.reference.collection('messages').add(
                        {
                          'time':DateTime.now(),
                           'uid' : FirebaseAuth.instance.currentUser!.email,
                           'message' : message.text,

                        }
                        
                      );
                      message.clear();
                        
                        },
                    child: Text("send"),
                   )
                   
                   
                ],
              ),
            
          ),
        ],
      )
      
      ,
    );
  }
}
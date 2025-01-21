import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
          Expanded(child: StreamBuilder(stream: widget.doc.reference.collection('messages').snapshots(), 
          builder: (context, snapshot){
            if(snapshot.hasData){
              if (snapshot.data?.docs.isEmpty ?? true){
                return Text("No messages yet!");

              }
              return ListView.builder(
                itemCount: snapshot.data?.docs.length ?? 0,
                itemBuilder: (context, index){
                  DocumentSnapshot msg = snapshot.data!.docs[index];
                  return Text(msg.data().toString());
                  
                
                

              } ,)


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
                      widget.doc.reference.collection('message').add(
                        {
                          'time':DateTime.now(),
                           'uid' : FirebaseAuth.instance.currentUser!.uid,

                        }
                      );
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
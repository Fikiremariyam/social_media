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
          Expanded(
            child: StreamBuilder(
            stream: widget.doc.reference.collection('messages').snapshots(), 
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
                    if (msg['uid']== FirebaseAuth.instance.currentUser!.email){
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children:[ Container(
                              width:MediaQuery.of(context).size.width * 0.5 ,
                               
                              decoration: BoxDecoration(
                                color: Colors.indigo.shade100,
                                borderRadius: BorderRadiusDirectional.circular(12.0),
                               
                            
                              ),
                              padding: EdgeInsets.all(9.0),
                              child: Text(msg['message'].toString()),
                            
                            ),
                                     ]
                          ),
                        SizedBox(height: 5,)
                        ],
                      );
                    }else{
                      return Column(
                        children: [
                          Row(
                            
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:[ Container(
                              width:MediaQuery.of(context).size.width * 0.5 ,
                               
                              decoration: BoxDecoration(
                                color: Colors.yellow.shade100,
                                borderRadius: BorderRadiusDirectional.circular(15.0),
                                
                            
                              ),
                              padding: EdgeInsets.all(9.0),
                              child: Text(
                                textAlign: TextAlign.left,
                                msg['message'].toString()),
                            
                            ),
                                     ]
                          ),
                        
                        SizedBox(height: 10)],
                      );
                    }
               
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
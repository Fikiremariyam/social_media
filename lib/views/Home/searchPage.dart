import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
    String? username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Search For A  user"),
        flexibleSpace: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue, Colors.purple],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  ),
  ) ,
        body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter user name",
              ),
              onChanged: (val){
                username=val;
                setState(() {// to refresh the state of ther name 
                  
                });
              },
            ),
          ),
           
          if (username != null)
          if (username!.length > 3) FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection('users').where('username',isEqualTo: username).get(),// passed the search result to the snapshot
            builder: (context,snapshot){
              var filtered = snapshot.data!.docs.where((doc){
                return doc['email'] != FirebaseAuth.instance.currentUser!.email;//exluding the seracers email 
              }
              ).toList();
              
             if(filtered.isEmpty ?? false){
                  return Text("No user Found!");
                }
              return Expanded(
                child: ListView.builder(
                  itemCount: filtered.length ?? 0,
                  itemBuilder: (context,index){
                    DocumentSnapshot doc = filtered[index];
                  
                  return ListTile(
                     title: Text(doc['username']),
                      trailing: FutureBuilder<DocumentSnapshot>(
                        future: doc.reference.collection('followers').doc(FirebaseAuth.instance.currentUser!.email).get() ,
                         builder: (context,snapshot){

                          if (snapshot.hasData){
                            if (snapshot.data?.exists ?? false){
                              return ElevatedButton(
                                onPressed: ()async{
                                  await doc.reference.collection('followers').doc(FirebaseAuth.instance.currentUser!.email).delete();
                                setState(() {}); // to refresh  the state it rebuild the whole app **not recomnded in production level apps          


                                },
                                child: Text("Un Follow")
                                );

                            }
                          }
                            return ElevatedButton(onPressed: () async {
                             await   doc.reference.collection('followers').doc(FirebaseAuth.instance.currentUser!.email).set(
                                {
                                  'followed by ': FirebaseAuth.instance.currentUser?.email,
                                  'time':DateTime.now(),

                                }// here we  are regstering the current email we have logeed in to to the followrs section for the searched account 
                                // improvemrnt : we can register the followed accouint to the cureent email  people i follow section 
                              );

                              setState(() {});
                            },
                             child: Text("Follow")
                             );
                          
                         })
                     
                  );
                
                }),
              );




            },),
             
        
        ],
      ),
    
    );
  }
}
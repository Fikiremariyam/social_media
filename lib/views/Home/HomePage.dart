import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_media/views/Home/searchPage.dart';
import 'package:social_media/views/Home/utils/image_post.dart';
import 'package:social_media/views/Home/utils/text_post.dart';
import 'package:social_media/views/auth/login.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}


class _HomepageState extends State<Homepage> {
  TextEditingController posttext =  TextEditingController();

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
            Expanded(child: Text( FirebaseAuth.instance.currentUser?.email ?? 'no email avalibe ' )),
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
      body: Padding(padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration( border: Border.all(color: Colors.green)),
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextFormField(
                  controller: posttext,
                  decoration: InputDecoration(
                    labelText:  "post something"


                  ),
                ),
                SizedBox(height: 4.0,),

                Row(children: [
                  ElevatedButton(
                    onPressed: () async {
                      var Data = {
                        'time':DateTime.now(),
                        'type':'text',
                        'content':posttext.text,
                        'uid':FirebaseAuth.instance.currentUser!.uid
                      };
                      FirebaseFirestore.instance.collection('posts').add(Data);
                      posttext.text="";
                      setState(() {
  
                      });


                    },
                    child: Text("post"),
                  )
                ],)

              ],
            ),
         
          )
          
          ,
          Expanded(
            child:FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.email).collection('timeline').get(),
            builder: (context,snapshot){

              if (snapshot.hasData){
                if (snapshot.data?.docs.isEmpty ??true){
                  return Text("noposts avalibe ");

                }else{
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length ?? 0 ,
                    itemBuilder: (context,index){
                      QueryDocumentSnapshot doc =  snapshot.data!.docs[index];
                      return FutureBuilder<DocumentSnapshot>(

                        future: FirebaseFirestore.instance.collection('posts').doc((snapshot.data?.docs[index].data() as Map)['posts'] ).get(),
                         builder: (context,postsnapshot){
                          print("=========================debugging===========");
                          print(snapshot.data!.docs[0]['content']);
                    
                          print("=========================close debugging===========");
                          if (postsnapshot.hasData){

                                var userData = postsnapshot.data!.data() as Map<String, dynamic>;

                              // Prepare the fields from the document data
                              List<Widget> fields = [];

                              userData.forEach((key, value) {
                                fields.add(
                                  Text('$key: $value', style: TextStyle(fontSize: 18)),
                                );
                              });

                              // Return the UI with user data
                              return ListView(
                                children: fields,
                              );
                            
                            return Text(postsnapshot.data.toString());
                            switch (postsnapshot.data!['type']){
                              case 'text':
                              return TextPost(text: postsnapshot.data!['content']);
                              case 'image':
                              return ImagePost(text: postsnapshot.data!['content'], url: postsnapshot.data!['url']);

                              default:
                              return TextPost(text: postsnapshot.data!['content']);

                            }
                          }else{
                            return  CircularProgressIndicator();
                          }
                         }
                         );
                    },
                    );
                }
              }else{
                return LinearProgressIndicator();
              }

            }) 
          )
        ],
      ),
      
      ),

      
    );
    }
}
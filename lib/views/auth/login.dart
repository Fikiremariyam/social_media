import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:social_media/views/Home/HomePage.dart';
import 'package:social_media/views/auth/signup.dart';
 
class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State <LogInPage> createState() =>  _LogInPageState();
}


bool showAuthResult(BuildContext context, String? errorMessage)  {
  if (errorMessage != null) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
    return true;
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Authentication Successful'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  
  return false;
  }
}

class  _LogInPageState extends State<LogInPage> {
  //ToDo  for me : ensure that the username is unique before regestring 

  GlobalKey<FormState> key = GlobalKey<FormState>();
  String? username;
  String? email;
  String? Password;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                    title: const Text("log in page  ")),
      body: Form(
        key:key,
        child: ListView(
          padding: const EdgeInsets.all(12.0),
          children: [
        const SizedBox(
                          height: 40.0,
                          ),
            TextFormField(
                          decoration:  const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "email",
                                      ),
                          validator: ValidationBuilder().email().maxLength(50).build(),
                          onChanged: (value){
                            email = value;
                          },
                          )
          ,const SizedBox(
                          height: 40.0,
                          ),
            TextFormField(
                          decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Password"
                                      ), 
                          
                          validator: ValidationBuilder().maxLength(50).build(),
                          onChanged: (value){
                            Password = value;
                          },
                          ),
                          

            const SizedBox(
                height: 12.0,
            ),
            SizedBox(
                    height:40.0,
                    child: ElevatedButton(
                      onPressed: () async{
                    if (key.currentState?.validate() ?? false) {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: Password!);
                        
                        showAuthResult(context, null);
                        if (mounted){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const Homepage()));
                    
                          }

                        } on FirebaseAuthException catch (
                          error) {
                          // Authentication failed
                          if (error is FirebaseAuthException) {
                            if (error.code == 'wrong-password') {
                              showAuthResult(context, 'wrong password.');
                            } else if (error.code == 'invalid-email') {
                              showAuthResult(context, 'there is no account registerd with this email ');
                            } else if (error.code == 'invalid-credential'){
                              showAuthResult(context, 'wrong emai or password .');

                            }
                              else {
                            
                              showAuthResult(context, 'An unexpected error occurred.');
                            }
                          } else {
                            showAuthResult(context, 'An unexpected exeption  occurred.');
                          }
                        };
                  }
                                                        }, 
              child:  const Text("login"))
            ),

          
          SizedBox(
            height: 12.0,
          ),
          SizedBox(
            height: 40,
            child: TextButton(
              child: Text("rgister if you dont have account"),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const Signup())
    
            ),

          ),
          )
          ],//children


        ),
      ),
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:social_media/Home/HomePage.dart';
import 'package:social_media/views/login.dart';
 
class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State <Signup> createState() =>  _SignupState();
}

void showSuccessMessage(BuildContext context, String? successMessage) {
  
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('You have logged in successfully!'),
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
}


void showAuthResult(BuildContext context, String? errorMessage) {
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
  }
}
class  _SignupState extends State<Signup> {
  //ToDo  for me : ensure that the username is unique before regestring 

  GlobalKey<FormState> key = GlobalKey<FormState>();
  String? username;
  String? email;
  String? Password;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                    title: const Text("Sign Up fuck u ")),
      body: Form(
        key:key,
        child: ListView(
          padding: const EdgeInsets.all(12.0),
          children: [
            TextFormField(
                          decoration:  const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "User Name",
                                      ),
                          validator: ValidationBuilder().maxLength(10).build(),
                          onChanged: (value){
                            username = value;
                          },
                          )
          ,const SizedBox(
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
                    child: ElevatedButton(onPressed: (){if (key.currentState?.validate() ?? false) {
  FirebaseAuth.instance.createUserWithEmailAndPassword(email: email!, password: Password!)
      .then((userCredential) {
        // Authentication successful
        showSuccessMessage(context, null);
        if (mounted){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const Homepage()));
      }

        
      })
      .catchError((error) {
        // Authentication failed
        if (error is FirebaseAuthException) {
          if (error.code == 'weak-password') {
            showAuthResult(context, 'Password is too weak.');
          } else if (error.code == 'email-already-in-use') {
            showAuthResult(context, 'Email is already in use.');
          } else {
            showAuthResult(context, 'An unexpected error occurred.');
          }
        } else {
          showAuthResult(context, 'An unexpected error occurred.');
        }
      });
}
                                                        }, 
              child:  const Text("signup"))
            )
          ],


        ),
      ),
    );
  }
}
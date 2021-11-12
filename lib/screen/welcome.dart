import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/screen/home.dart';


class WelcomeScreen extends StatelessWidget {

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Text(auth.currentUser!.email!, style: TextStyle(fontSize: 25),),
              ElevatedButton(
                child: Text("Log out"),
                onPressed: (){
                  auth.signOut().then((value){
                    Navigator.pushReplacement(context,
                    MaterialPageRoute(
                    builder: (context) {
                    return HomeScreen();
                    }));
                  });
                }, 
              )
            ],
          ),
        ),
      ),
    );
  }
}
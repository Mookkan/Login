import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:login/model/profile.dart';
import 'package:login/screen/home.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(
    email: '',
    password: '',
  );
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  get errorText => null;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
                appBar: AppBar(
                  title: Text("Register"),
                  backgroundColor: Colors.purple[100],
                ),
                body: Container(
                  color: Colors.deepPurple[30],
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: formKey,
                        child: SingleChildScrollView(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.pink[100]!,
                                    Colors.yellow[100]!
                                  ],
                                )),
                            margin: EdgeInsets.all(32),
                            padding: EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 5, 20, 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.purple[50],
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 15, right: 15, top: 0),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Email',
                                            fillColor: Colors.purple[50],
                                            focusColor: Colors.purple[50]),
                                        validator: (EmailValidator(
                                            errorText: "invalid email")),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        onSaved: (String? email) {
                                          profile.email = email!;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(20, 5, 20, 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.purple[50],
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '    Password',
                                        fillColor: Colors.white70,
                                      ),
                                      validator: (value) {
                                        if (value!.isNotEmpty)
                                          return null;
                                        else
                                          return 'please enter your password';
                                      },
                                      obscureText: true,
                                      onSaved: (String? password) {
                                        profile.password = password!;
                                      },
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(21,0,4,0),
                                            child: Center(
                                              child: SizedBox(
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      primary: Colors.purple[100],
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  12))),
                                                  child: Text("Register",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(fontSize: 16)),
                                                  onPressed: () async {
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      formKey.currentState?.save();
                                                      try {
                                                        await FirebaseAuth.instance
                                                            .createUserWithEmailAndPassword(
                                                                email: profile.email,
                                                                password:
                                                                    profile.password)
                                                            .then((value) {
                                                          formKey.currentState
                                                              ?.reset();
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "Your account has been successfully created",
                                                              gravity: ToastGravity
                                                                  .CENTER);
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) {
                                                            return HomeScreen();
                                                          }));
                                                        });
                                                      } on FirebaseAuthException catch (e) {
                                                        Fluttertoast.showToast(
                                                            msg: e.message!,
                                                            gravity:
                                                                ToastGravity.CENTER);
                                                      }
                                                    }
                                                    
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(2,0,25,0),
                                              child: SizedBox(
                                                child: ElevatedButton(
                                                  child: Text("Cencel",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                      )),
                                                  onPressed: () {
                                                    Navigator.pushReplacement(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return HomeScreen();
                                                    }));
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      primary: Colors.purple[100],
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  12))),
                                                ),
                                              ),
                                            ),
                                          ),
                                        
                                      ],
                                    ),
                                ),
                                
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ));
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}

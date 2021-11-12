import 'package:flutter/material.dart';
import 'package:login/screen/login.dart';
import 'package:login/screen/register.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        title: Text("Register/Login"),
        backgroundColor: Colors.indigo[200]
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 100, 10, 80),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                   child: ElevatedButton.icon(
                    icon: Icon(Icons.add),
                    label: Text("New Account", style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54)),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return RegisterScreen();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                    fixedSize: const Size(300, 80),
                     primary: Colors.indigo[200],
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: SizedBox(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.login),
                      label: Text("Login", style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54)),
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return LoginScreen();
                        }));
                      },
                     style: ElevatedButton.styleFrom(
                     fixedSize: const Size(300, 80),
                     primary: Colors.indigo[200],
                     shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(12))
                    ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

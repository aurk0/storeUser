import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:registration/page1.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _passcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Image.asset(
            'assets/sky.jpg',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Form(
            key: _key,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Log In',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35),
                    ),
                    Text(
                      'FireStore',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Text(
                      'Register using email & pass',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailcontroller,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.mail_rounded,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Enter Email",
                          hintStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              borderSide: BorderSide(color: Colors.green)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              borderSide: BorderSide(color: Colors.red))),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      obscureText: true,
                      controller: _passcontroller,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_rounded,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Enter Password",
                          hintStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              borderSide: BorderSide(color: Colors.green)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              borderSide: BorderSide(color: Colors.red))),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: TextButton(
                          onPressed: () async {
                            if (_key.currentState.validate()) {
                              login();
                            }
                          },
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          )),
                      height: 54,
                      width: 500,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: LinearGradient(
                              colors: [Colors.red[900], Colors.green[900]])),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  //login code
  void login() async {
    try {
      final User user = (await auth.signInWithEmailAndPassword(
        email: _emailcontroller.text,
        password: _passcontroller.text,
      ))
          .user;

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return Page1(
          user: user,
        );
      }));
    } catch (e) {
      print(e);
    }
  }
}

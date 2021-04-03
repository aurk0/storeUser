import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:registration/cloudestore.dart';
import 'package:registration/login.dart';
import 'package:registration/main.dart';
import 'package:registration/page1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
//sharedPreference
  // String displayName = "";
  // void initState() {
  //   getData();
  // }

  // getData() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   setState(() {
  //     displayName = pref.getString('displayname');
  //   });
  // }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passcontroller = TextEditingController();
  TextEditingController _displayname = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'REGISTRATION',
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
                      height: 10,
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(5),
                    //   child: display(),
                    // ),
                    SizedBox(
                      height: 60,
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
                      controller: _displayname,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.people_outline_rounded,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Enter Name",
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
                              regAccount();
                            }
                          },
                          child: Text(
                            'REGISTER',
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
                    TextButton(
                        onPressed: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login())),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline),
                        ))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void regAccount() async {
    final User user = (await auth.createUserWithEmailAndPassword(
            email: _emailcontroller.text, password: _passcontroller.text))
        .user;
    if (user != null) {
      await Store()
          .storeData(_displayname.text, _emailcontroller.text, user.uid);
      await user.updateProfile(displayName: _displayname.text);
      final user1 = auth.currentUser;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Page1(
                user: user1,
              )));
    }
  }

  // display() {
  //   if (displayName != null) {
  //     return Text(
  //       'Welcome Back $displayName!',
  //       style: TextStyle(
  //           color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
  //     );
  //   } else {
  //     return Text(
  //       'Welcome!',
  //       style: TextStyle(
  //           color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
  //     );
  //   }
  // }
}

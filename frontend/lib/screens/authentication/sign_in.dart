import 'package:frontend/constants/colors.dart';
import 'package:frontend/constants/description.dart';
import 'package:frontend/constants/styles.dart';
import 'package:frontend/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  const SignIn({super.key, required this.toggle});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //ref for the AuthSrivice class
  final AuthServices _auth = AuthServices();

  //form key
  final _formkey = GlobalKey<FormState>();

  //states
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: bgBlack,
          // appBar: AppBar(
          //   backgroundColor: bgBlack,
          //   elevation: 0,
          //   title: const Text("SIGN IN",
          //       style: TextStyle(fontWeight: FontWeight.w700)),
          // ),
          body: SingleChildScrollView(
         child: Column(
          children: [
            Container(
              width: w,
              height: h * 0.4,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/signup.png"),
                      fit: BoxFit.cover)),
              child: Column(
                children: [
                  SizedBox(
                    height: h * 0.16,
                  ),
                  
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
        
                  Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 40,
                              ),
                              //email
                              TextFormField(
                                style: TextStyle(color: Colors.black),
                                decoration: txtInputDecoration,
                                validator: (value) => value?.isEmpty == true
                                    ? "Enter an Email"
                                    : null,
                                onChanged: (value) {
                                  setState(() {
                                    email = value;
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              //password
                              TextFormField(
                                obscureText: true,
                                style: TextStyle(color: Colors.black),
                                decoration: txtInputDecoration.copyWith(
                                    hintText: "password"),
                                validator: (value) =>
                                    value!.length < 6 ? "Enter an Email" : null,
                                onChanged: (value) {
                                  setState(() {
                                    password = value;
                                  });
                                },
                              ),
                              //google
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                error,
                                style: TextStyle(color: Colors.red),
                              ),
                              const Text(
                                "Login with social accounts",
                                style: descriptionStyle,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  //go to google login
                                },
                                child: CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              AssetImage("assets/images/g.png"),
                        ),
                              ),
                              //register
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Do not have an account ? ",
                                    style: descriptionStyle,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      widget.toggle();
                                    },
                                    child: Text("REGISTER",
                                        style: TextStyle(
                                            color: Color.fromARGB(255, 220, 0, 143),
                                            fontWeight: FontWeight.w600)),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              //button
                              GestureDetector(
                                onTap: () async {
                                  dynamic result =
                                      await _auth.signinUsingEmailAndPassword(
                                          email, password);
              
                                  if (result == null) {
                                    setState(() {
                                      error = "Credentials do not match";
                                    });
                                  }
                                },
                                child: Container(
                                  height: 40,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: bgBlack,
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          width: 2, color: mainYellow)),
                                  child: Center(
                                      child: Text(
                                    "LOG IN",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 220, 0, 143),
                                        fontWeight: FontWeight.w700),
                                  )),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  dynamic result =
                                      await _auth.signInAnonymously();
                                  if (result == Null) {
                                    print("Error in Sign In");
                                  } else {
                                    print("Signed In");
                                  }
                                },
                                child: Container(
                                  height: 40,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: bgBlack,
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          width: 2, color: mainYellow)),
                                  child: Center(
                                      child: Text(
                                    "LOG IN AS GUEST",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 220, 0, 143),
                                        fontWeight: FontWeight.w700),
                                  )),
                                ),
                              )
                              //anonymous
                            ],
                          )),
                    )
                  // Row(
                  //   children: [
                  //     Expanded(child: Container(),),
                  //   ],
                  // ),
                ],
              ),
            ),
            
            
          ],
        ),
      )
          ),
    );
  }
}

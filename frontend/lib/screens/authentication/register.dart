import 'package:flutter/material.dart';
import 'package:frontend/constants/colors.dart';
import 'package:frontend/constants/description.dart';
import 'package:frontend/constants/styles.dart';
import 'package:frontend/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggle;
  const Register({super.key, required this.toggle});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //ref for the AuthSrivice class
  final AuthServices _auth = AuthServices();

  //form key
  final _formkey = GlobalKey<FormState>();

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
          
          body: SingleChildScrollView(
              child: Column(
          children: [
            Container(
              width: w,
              height: h * 0.4,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/loginimg.png"),
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
                              validator: (value) => value!.length < 6
                                  ? "Password must be atleast 6 characters"
                                  : null,
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
                              "Register with social accounts",
                              style: descriptionStyle,
                            ),
                            const SizedBox(
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
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already Have an Account ? ",
                                  style: descriptionStyle,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    widget.toggle();
                                  },
                                  child: Text("LOGIN",
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
                                    await _auth.registerWithEmailAndPassword(
                                        email, password);

                                if (result == null) {
                                  setState(() {
                                    error = "Please enter a valid email";
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
                                  "REGISTER",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 220, 0, 143),
                                      fontWeight: FontWeight.w700),
                                )),
                              ),
                            ),
                            //anonymous
                          ],
                        )),
                  ),
                ],
              ),
            ),
            
            
          ],
        ),
      )),
    );
  }
}

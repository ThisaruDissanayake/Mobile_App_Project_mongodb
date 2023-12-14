import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/constants/colors.dart';
import 'package:frontend/constants/description.dart';
import 'package:frontend/services/auth.dart';
import 'package:frontend/views/shared/appstyle.dart';
import 'package:frontend/views/shared/reusable_text.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthServices _auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: bgBlack,
        appBar: AppBar(
          backgroundColor: const Color(0xFFF2E2E2),
          elevation: 0,
          leading: const Icon(
            Icons.qr_code_scanner,
            size: 18,
            color: Colors.black,
          ),
          title: const Text(" YOUR PROFIEL"),
          actions: [
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(bgBlack)),
                onPressed: () async {
                  await _auth.signOut();
                },
                child: const Icon(Icons.logout)),
          
          
          
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //SvgPicture.asset('assets/images/',width:15.w,height:25,),

                    SizedBox(
                      width: 5.w,
                    ),

                    Container(
                      height: 15.h,
                      width: 1.w,
                      color: Colors.grey,
                    ),
                    // reusableText(
                    //     text: "Sri Lanka",
                    //     style: appstyle(16, Colors.black, FontWeight.normal)),
                    SizedBox(
                      width: 10.w,
                    ),

                    const Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Icon(
                        Icons.settings,
                        color: Colors.black,
                        size: 18,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
            
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                Text(
                  "This is Profile Page",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
                const SizedBox(
                  height: 20,
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:frontend/views/Ui/auth/login.dart";
//import "package:flutter_svg/svg.dart";
import "package:frontend/views/shared/appstyle.dart";
import "package:frontend/views/shared/reusable_text.dart";

class NonUser extends StatelessWidget {
  const NonUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFF2E2E2),
          elevation: 0,
          leading: const Icon(
            Icons.qr_code_scanner,
            size: 18,
            color: Colors.black,
          ),
          actions: [
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
                    reusableText(
                        text: "Sri Lanka",
                        style: appstyle(16, Colors.black, FontWeight.normal)),
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
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
                height: 750.h,
                decoration: const BoxDecoration(color:  Color(0xFFF2E2E2)),
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(12, 10, 16, 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 35.h,
                                  width: 35.w,
                                  child: const CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assest/images/user.jpeg'),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                reusableText(
                                    text:
                                        "Hello ,Please Login in to your Account ",
                                    style: appstyle(
                                        12, Colors.grey.shade600, FontWeight.normal)),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const LoginPage()));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 5),
                                width: 50.w,
                                height: 30.h,
                                decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Center(
                                  child: reusableText(
                                      text: "Login",
                                      style: appstyle(
                                          12, Colors.white, FontWeight.normal)),
                                ),
                              ),
                            )
                          ],
                        ))
                  ],
                ))
          ]),
        )
        
        );
  }
}

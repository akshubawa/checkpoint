// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:checkpoint/api/api_service.dart';
import 'package:checkpoint/screen/ui/screen.dart';
import 'package:checkpoint/views/auth/signup_view.dart';
import 'package:checkpoint/widgets/background.dart';
import 'package:checkpoint/widgets/buttons/text_buttons.dart';
import 'package:checkpoint/widgets/snackbar/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isSigningIn = false;
  bool isGoogleSigningIn = false;
  bool status = false;
  final ApiService apiService = ApiService();
  late SharedPreferences prefs;

  bool isshown = true;

  Future<void> loginAccount() async{
    setState(() {
      isSigningIn = true;
    });

    final headers = <String, String>{
      'Content-Type': 'application/json'
    };

    Map body = {
      "identifier" : email.text.trim().toString(),
      "password" : password.text.trim().toString()
    };
    try {
      var response = await apiService.post('login', headers: headers, body: body, jsonEncodeBody: true);
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      
      setState(() {
        isSigningIn = false;
      });
      if(jsonResponse["success"]) {
        var myToken = jsonResponse["token"];
        prefs.setString("token", myToken);
        CustomSnackbar.show(context, "Login Successfully.", "green");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Screen()));
      }
      else {
        CustomSnackbar.show(context, jsonResponse["message"], "red");
      }
    }
    catch (e) {
      CustomSnackbar.show(context, "Something went wrong!", "red");
      debugPrint(e.toString());
       setState(() {
        isSigningIn = false;
      });
    }
  }

  @override
  void initState() {
    initSharedPref();
    super.initState();
  }

   void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
          persistentFooterButtons: [SizedBox(
                          width: double.infinity,
                          child: TextButtonWithGradient(
                            onPressed: (BuildContext contex) async{
                              await loginAccount();
                            },
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xff2789e4),
                                Color(0xff6c77d0),
                                Color(0xff9b6bd2)
                              ],
                              stops: [0.16, 0.5, 0.87],
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                            ),
                            child: isSigningIn
                                ? const SpinKitCircle(
                                    color: Colors.blue,
                                    size: 30,
                                  )
                                : Text('Login',
                                    style: GoogleFonts.outfit(
                                        color: Colors.white, fontSize: 20)),
                          ),
                        ),
                        ],
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            width: double.maxFinite,
            height: screenHeight * .95,
            child: Stack(
              children: [
                CustomPaint(
                  size: Size(screenWidth * .6, screenHeight * 0.25),
                  painter: BackgroundPainter0(),
                ),
                Positioned(
                  top: screenHeight * 0.5,
                  right: -20,
                  child: CustomPaint(
                    size: Size(screenWidth * .21, screenHeight * 0.13),
                    painter: BackgroundPainter1(),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.85,
                  left: -30,
                  child: CustomPaint(
                    size: Size(screenWidth * .25, screenHeight * 0.126),
                    painter: BackgroundPainter2(),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.9,
                  right: -10,
                  child: CustomPaint(
                    size: Size(screenWidth * .5, screenHeight * 0.126),
                    painter: BackgroundPainter3(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * .04,
                      vertical: screenHeight * .025),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Login',
                          style: GoogleFonts.outfit(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        SizedBox(
                          height: screenHeight * .02,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email ID',
                              style: GoogleFonts.redHatDisplay(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.5), // Shadow color
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                controller: email,
                                onTapOutside: (event) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                style: const TextStyle(
                                  color: Color.fromRGBO(40, 46, 54, 1),
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors
                                      .white, // Ensure background color remains white
                                  suffixIcon: const Icon(
                                    Icons.info_outline_rounded,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                  hintText: 'Employee ID or Enter Email',
                                  hintStyle: GoogleFonts.redHatDisplay(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey
                                          .shade300, // Lighter border color
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        8.0), // Optional: Add rounded corners
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey
                                          .shade300, // Lighter border color when enabled
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey
                                          .shade400, // Slightly darker when focused
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * .015,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Password',
                              style: GoogleFonts.redHatDisplay(
                                  color: Colors.grey, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.5), // Shadow color
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: password,
                                obscureText: isshown,
                                onTapOutside: (event) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                style: const TextStyle(
                                  color: Color.fromRGBO(40, 46, 54, 1),
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      isshown
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isshown = !isshown;
                                      });
                                    },
                                  ),
                                  hintText: 'Password',
                                  hintStyle: GoogleFonts.redHatDisplay(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey
                                          .shade300, // Lighter border color
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        8.0), // Optional: Add rounded corners
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey
                                          .shade300, // Lighter border color when enabled
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey
                                          .shade400, // Slightly darker when focused
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * .02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Row(
                            //   children: [
                            //     FlutterSwitch(
                            //       width: 45.0,
                            //       height: 25.0,
                            //       valueFontSize: 20.0,
                            //       toggleSize: 20.0,
                            //       value: status,
                            //       borderRadius: 25.0,
                            //       padding: 2.0,
                            //       activeColor: Colors.blue,
                            //       inactiveColor: Colors.grey.shade300,
                            //       toggleColor: Colors.white,
                            //       onToggle: (val) {
                            //         setState(() {
                            //           status = val;
                            //         });
                            //       },
                            //     ),
                            //     const SizedBox(
                            //   width: 5,
                            // ),
                            // Text(
                            //   'Keep me logged in',
                            //   style: GoogleFonts.outfit(
                            //       color: Colors.black54, fontSize: 16),
                            // ),
                            //   ],
                            // ),
                            
                            Text('Forgot Password?',
                            style: GoogleFonts.outfit(
                                color: const Color.fromRGBO(73, 84, 99, 1),
                                fontSize: 16)),
                      
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * .02,
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Dont have an account? ",
                                style: GoogleFonts.outfit(fontSize: 15)),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignUp(),
                                    ));
                              },
                              child: Text(
                                "Register Here",
                                style: GoogleFonts.outfit(
                                    color: Colors.blueAccent, fontSize: 15),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        ]),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  bool isEmailValid(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }
}
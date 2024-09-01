import 'dart:convert';

import 'package:checkpoint/api/api_service.dart';
import 'package:checkpoint/screen/ui/screen.dart';
import 'package:checkpoint/views/auth/login_view.dart';
import 'package:checkpoint/widgets/background/background.dart';
import 'package:checkpoint/widgets/buttons/text_buttons.dart';
import 'package:checkpoint/widgets/snackbar/custom_snackbar.dart';
import 'package:checkpoint/widgets/textfields/custom_texfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uicons_pro/uicons_pro.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isSigningUp = false;
  bool characters = false;
  bool num = false;
  bool special = false;
  bool usernameError = false;
  bool emailError = false;
  bool passwordError = false;
  bool showPassword = false;
  int total = 0;
  TextEditingController controller = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // TextEditingController empIdController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController departmentController = TextEditingController();

  late String platform = "";
  late String deviceToken = "";

  late SharedPreferences prefs;

  @override
  void initState() {
    initSharedPref();
    getDeviceToken();
    super.initState();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> getDeviceToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    String deviceType = defaultTargetPlatform == TargetPlatform.android
        ? "android"
        : defaultTargetPlatform == TargetPlatform.iOS
            ? "ios"
            : "unknown";

    setState(() {
      platform = deviceType;
      deviceToken = token ?? "";
    });

    }


  final ApiService apiService = ApiService();

  Future<void> registerAccount() async{
    setState(() {
      isSigningUp = true;
    });

    final headers = <String, String>{
      'Content-Type': 'application/json'
    };

    Map body = {
    "email":emailController.text.trim().toString(),
    "firstName":firstNameController.text.trim().toString(),
    "lastName": lastNameController.text.trim().toString(),
    "password": passwordController.text.trim().toString(),
    // "role": departmentController.text.trim().toString(),
    "role": roleController.text.trim().toString().toLowerCase() ,
    // "departmentName": departmentController.text.trim().toLowerCase(),
    "departmentName": "finance department",
    "deviceInfo" : {
      "platform": platform,
      "deviceToken": deviceToken
    }
};
    try {
      var response = await apiService.post('signup', headers: headers, body: body, jsonEncodeBody: true);
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      print(response.statusCode);
      
      setState(() {
        isSigningUp = false;
      });
      if(jsonResponse["success"]) {
        var myToken = jsonResponse["token"];
        prefs.setString("token", myToken);
        
        CustomSnackbar.show(context, "Registered Successfully.", "green");
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
        isSigningUp = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        persistentFooterButtons: [SizedBox(
                          width: screenWidth,
                          child: TextButtonWithGradient(
                            onPressed: (p0)async {
                              await registerAccount();
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
                            child: isSigningUp
                                ? const SpinKitCircle(
                                    color: Colors.blue,
                                    size: 30,
                                  )
                                : Text(
                                    'Submit',
                                    style: GoogleFonts.outfit(
                                        color: Colors.white, fontSize: 20),
                                  ),
                          ),
                        )
                      ],
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SizedBox(
          height: screenHeight,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
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
                    top: screenHeight * 0.8,
                    left: -30,
                    child: CustomPaint(
                      size: Size(screenWidth * .25, screenHeight * 0.126),
                      painter: BackgroundPainter2(),
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.85,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(UIconsPro
                                    .regularRounded.arrow_circle_left)),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'SignUp',
                              style: GoogleFonts.outfit(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          'Full Name',
                          style: GoogleFonts.redHatDisplay(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 2,
                              child: CustomTextfield(
                                obscureText: false,
                                keyboardType: TextInputType.name,
                                onSubmission: (p0) {},
                                hint: "First Name",
                                controller: firstNameController,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              flex: 3,
                              child: CustomTextfield(
                                obscureText: false,
                                keyboardType: TextInputType.name,
                                onSubmission: (p0) {},
                                hint: "Last Name",
                                controller: lastNameController,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * .02),
                        Text(
                          'Email',
                          style: GoogleFonts.redHatDisplay(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                        CustomTextfield(
                            obscureText: false,
                            hint: "Enter Email",
                            controller: emailController,
                            onSubmission: (value) {
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(value)) {
                                setState(() {
                                  emailError = true;
                                });
                              } else {
                                setState(() {
                                  emailError = false;
                                });
                              }
                            },
                            keyboardType: TextInputType.emailAddress),
                        SizedBox(height: screenHeight * .02),
                        // Text(
                        //   'Employee ID',
                        //   style: GoogleFonts.redHatDisplay(
                        //       color: Colors.grey[600],
                        //       fontWeight: FontWeight.w500,
                        //       fontSize: 15),
                        // ),
                        // CustomTextfield(
                        //     hint: "Enter Employee Id",
                        //     controller: empIdController,
                        //     keyboardType: TextInputType.text,
                        //     obscureText: false),
                        // SizedBox(height: screenHeight * .02),
                        Text(
                          'Role',
                          style: GoogleFonts.redHatDisplay(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                        DropdownSearch<String>(
                          items: const [
                            // "GAIL Bhawan, New Delhi",
                            // "GAIL (India) Limited, Mumbai Office",
                            // "GAIL (India) Limited, Kolkata Office",
                            // "GAIL (India) Limited, Chennai Office",
                            // "GAIL (India) Limited, Hyderabad Office",
                            // "GAIL (India) Limited, Bengaluru Office",
                            // "GAIL (India) Limited, Vadodara Office",
                            "Employee",
                            "Admin",
                            "Manager",
                          ],
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          onChanged: (String? selectedItem) {
                            roleController.text = selectedItem ?? "";
                          },
                          popupProps: const PopupProps.menu(
                            showSearchBox: true,
                            searchFieldProps: TextFieldProps(
                              decoration: InputDecoration(
                                labelText: 'Search',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          dropdownBuilder: (context, selectedItem) {
                            return Text(
                              selectedItem ?? "",
                              style: const TextStyle(fontSize: 16),
                            );
                          },
                        ),
                        SizedBox(height: screenHeight * .02),
                        Text(
                          'Department',
                          style: GoogleFonts.redHatDisplay(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                        DropdownSearch<String>(
                          items: const [
                            'Human Resources',
                            'Finance',
                            'Marketing',
                            'Sales',
                            'IT',
                            'Legal',
                            'Customer Service',
                            'Research and Development',
                            'Operations',
                            'Administration'
                          ],
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          onChanged: (String? selectedItem) {
                            departmentController.text = selectedItem ?? "";
                          },
                          popupProps: const PopupProps.menu(
                            showSearchBox: true,
                            searchFieldProps: TextFieldProps(
                              decoration: InputDecoration(
                                labelText: 'Search',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          dropdownBuilder: (context, selectedItem) {
                            return Text(
                              selectedItem ?? "",
                              style: const TextStyle(fontSize: 16),
                            );
                          },
                        ),

                        SizedBox(height: screenHeight * .02),
                        Text(
                          'Password',
                          style: GoogleFonts.redHatDisplay(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                        CustomTextfield(
                          keyboardType: TextInputType.text,
                          obscureText: !showPassword,
                          suffix: GestureDetector(
                            onTap: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            child: Icon(
                              Icons.remove_red_eye,
                              color: showPassword ? Colors.blue : Colors.grey,
                            ),
                          ),
                          hint: "Password",
                          controller: passwordController,
                          onChange: (value) {
                            setState(() {
                              characters = value.length >= 8;
                              num = value.contains(RegExp(r'\d+'));
                              special =
                                  value.contains(RegExp(r'[^a-zA-Z0-9\s]'));
                              total = (characters ? 1 : 0) +
                                  (num ? 1 : 0) +
                                  (special ? 1 : 0);
                            });
                          },
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        SizedBox(
                          height: 4,
                          child: Row(
                            children: [
                              Expanded(
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 400),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: total >= 1
                                          ? Colors.green
                                          : Colors.grey),
                                ),
                              ),
                              Expanded(
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 400),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: total >= 2
                                          ? Colors.green
                                          : Colors.grey),
                                ),
                              ),
                              Expanded(
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 400),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: total >= 3
                                          ? Colors.green
                                          : Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  characters ? Colors.green : Colors.grey,
                              radius: 3.5,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              "At least 8 character",
                              style: GoogleFonts.outfit(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: num ? Colors.green : Colors.grey,
                              radius: 3.5,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              "1 Numerical character",
                              style: GoogleFonts.outfit(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  special ? Colors.green : Colors.grey,
                              radius: 3.5,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              "1 Special character",
                              style: GoogleFonts.outfit(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account? ",
                                style: GoogleFonts.outfit(fontSize: 15)),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ));
                              },
                              child: Text(
                                "Login Here",
                                style: GoogleFonts.outfit(
                                    color: Colors.blueAccent, fontSize: 15),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
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
    );
  }

  void _signUp() async {
    // setState(() {
    //   isSigningUp = true;
    // });

    // User? user = await _auth.signUpWithEmailAndPassword(
    //     email.trim(), password.trim(), context, texttheme);

    // setState(() {
    //   isSigningUp = false;
    // });

    // if (user != null) {
    //   saveData("User", username);
    //   saveData("Email", email);
    //   saveData("Userid", user.uid);
    //   final signUpModal = SignUpModal(
    //       avatar: 'images/profile.jpg',
    //       id: user.uid,
    //       username: username.trim(),
    //       email: email.trim());
    //   _addController.addUser(signUpModal, user.uid);

    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //     content: Text("User is successfully created"),
    //   ));
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => Screen(email: email),
    //       ));
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //     content: Text("Some error happend"),
    //   ));
    // }
  }
}
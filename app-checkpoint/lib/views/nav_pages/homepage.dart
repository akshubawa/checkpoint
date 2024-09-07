// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:checkpoint/api/api_service.dart';
import 'package:checkpoint/widgets/circle_widgets/in_home_widget.dart';
import 'package:checkpoint/widgets/circle_widgets/in_office_widget.dart';
import 'package:checkpoint/views/notification.dart';
import 'package:checkpoint/widgets/background/background.dart';
import 'package:checkpoint/widgets/snackbar/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:uicons_pro/uicons_pro.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
      
  final String company = "GAIL Limited, Greater Noida Office";
  final String date = "";
  bool _playRippleAnimation = false; // Move this outside the build method
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;
  String _timeString = "";
  String _dateString = "";
  Timer? _timer;
  bool isActive = false;

  File? selectedImage;


  double latitude = 0; // Current location latitude
  double longitude = 0; // Current location longitude

  double targetLatitude = 28.449371;
  double targetLongitude = 77.584114;

  double distanceInMeters = 0.0;
  bool isInRange = false;
  String? cityName;
  bool inOffice = false;
  late String token = "";

  DateTime? checkInTime;
  DateTime? checkOutTime;
  late String? workingHour = "--:--";
  bool isLoading = true;
  late Map jwtDecodedToken = {};
  late String employee_id = "";
  late bool isVerified = true;

  DateTime? checkInStartTime;

  void getLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });

    calculateDistance();
  }

  void calculateDistance() async{
    distanceInMeters = Geolocator.distanceBetween(
      latitude,
      longitude,
      targetLatitude,
      targetLongitude
    );

    // Check if the distance is within 200 meters
    isInRange = distanceInMeters <= 200;
    getLocationDetails(latitude, longitude);
    setState(() {
      // Update the UI with the distance and range status
    });
    

    debugPrint('Distance: $distanceInMeters meters');
    debugPrint(isInRange ? 'In range' : 'Not in range');
  }

  void getLocationDetails(double givenLatitude, double givenLongitude) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      givenLatitude,
      givenLongitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      // print(placemarks);
      setState(() {
        cityName = place.locality ?? 'Unknown'; // Update the instance variable
      });
      debugPrint(cityName);
    }
  } catch (e) {
    debugPrint('Error getting city name: $e');
  }
}

  void getTokenFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? storedToken = prefs.getString('token');
    
    if (storedToken != null) {
      setState(() {
        token = storedToken;
        jwtDecodedToken = JwtDecoder.decode(token);
      });
      // print(token);
      print(jwtDecodedToken);
    }
    getActiveStatus();
    getCheckInCheckOutData();
    // print(jwtDecodedToken);
  }

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _timeString = _formatTime(DateTime.now());
    _dateString = _formatDate(DateTime.now());
    _timer =
        Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateTime());
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(_flipController);
    getLocation();
    getTokenFromPrefs();
    loadCheckInStatus();
  }

  @override
  void dispose() {
    _flipController.dispose();
    _timer?.cancel(); // Cancel the timer to avoid memory leaks

    super.dispose();
  }

   Future<void> loadCheckInStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      inOffice = prefs.getBool('inOffice') ?? false;
      isActive = prefs.getBool('isActive') ?? false;
      if (isActive) {
        _flipController.forward();
        String? storedStartTime = prefs.getString('checkInStartTime');
        if (storedStartTime != null) {
          checkInStartTime = DateTime.parse(storedStartTime);
          _startTimer();
        }
      } else {
        _flipController.reverse();
      }
    });
  }

  void _startTimer() {
    _workingTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (checkInStartTime != null) {
        Duration difference = DateTime.now().difference(checkInStartTime!);
        setState(() {
          _counter = difference.inSeconds;
          formattedCounter = _formatDuration(difference);
        });
      }
    });
  }

  Future<void> checkInOut(BuildContext context, String command) async {
    try {
      final Map<String, String> headers = {
        'Authorization': 'Bearer $token',
      };

      final response = await apiService.post(command, headers: headers, body: "");
      
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        if (command == 'checkin') {
          checkInStartTime = DateTime.now();
          await prefs.setString('checkInStartTime', checkInStartTime!.toIso8601String());
          await prefs.setBool('inOffice', true);
          await prefs.setBool('isActive', true);
          setState(() {
            inOffice = true;
            isActive = true;
          });
          _startTimer();
          _flipController.forward();
        } else {
          await prefs.remove('checkInStartTime');
          await prefs.setBool('inOffice', false);
          await prefs.setBool('isActive', false);
          setState(() {
            inOffice = false;
            isActive = false;
            _counter = 0;
            formattedCounter = "00:00:00";
            checkInStartTime = null;
          });
          _workingTimer.cancel();
          _flipController.reverse();
        }
        
        CustomSnackbar.show(context, (command == 'checkin')? "Check-in Successful." : "Check-out Successful.", "green");
      } else {
        CustomSnackbar.show(context, "Failed to $command. Please try again later.", "red");
      }
    } catch (e) {
      CustomSnackbar.show(context, "Something went wrong. Please try again later.", "red");
      debugPrint(e.toString());
    }
  }

  void _onTap() async {
    if (isInRange) {
      if (!_flipController.isAnimating) {
        setState(() {
          _playRippleAnimation = true;
        });
        if (!inOffice) {
          // await _pickImageFromCamera();
          // if (selectedImage != null) {
            if (isVerified){
              checkInOut(context, "checkin");
            // }
          } else {
            setState(() {
              _playRippleAnimation = false;
            });
          }
        } else {
          checkInOut(context, "checkout");
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You are not in range"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }


  int _counter = 0;
  late Timer _workingTimer;
  String formattedCounter = "00:00:00";
  final ApiService apiService = ApiService();


  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  Future<void> getCheckInCheckOutData() async {
  try {
    final headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final response = await apiService.get(
      'get-checkin-checkout',
      headers: headers,
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    print(jsonResponse);

    if (jsonResponse['success'] == true) {
      setState(() {
        checkInTime = jsonResponse.containsKey('checkInTime') && jsonResponse['checkInTime'] != null
            ? DateTime.parse(jsonResponse['checkInTime'])
            : null;
        checkOutTime = jsonResponse.containsKey('checkOutTime') && jsonResponse['checkOutTime'] != null
            ? DateTime.parse(jsonResponse['checkOutTime'])
            : null;
       if (jsonResponse.containsKey('totalWorkingHours') && jsonResponse['totalWorkingHours'] != null) {
          double hours = double.parse(jsonResponse['totalWorkingHours'].toString());
          int totalMinutes = (hours * 60).toInt();
          int hoursPart = totalMinutes ~/ 60;
          int minutesPart = totalMinutes % 60;

          workingHour = '${hoursPart.toString().padLeft(2, '0')}:${minutesPart.toString().padLeft(2, '0')}';
        } else {
          workingHour = null;
        }
      });
    } else if (jsonResponse['success'] == false) {
      setState(() {
        checkInTime = null;
        checkOutTime = null;
        workingHour = null;
      });
      CustomSnackbar.show(
          context, "Failed to fetch working hours. Please try again later.", "red");
    }
  } catch (e) {
    CustomSnackbar.show(context, "Something went wrong. Please try again later.", "red");
    print('Error in CheckInCheckOut API call: $e');
  } finally {
    setState(() {
      isLoading = false; // Stop loading
    });
  }
}

Future<void> getProfileData() async {
    try {
      final headers = <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await apiService.get(
        'get-account-details',
        headers: headers,
      );
      Map jsonResponse = jsonDecode(response.body);
      print(jsonResponse);

      if (jsonResponse['success'] && jsonResponse.containsKey('user')) {
        setState(() {
          employee_id = jsonResponse['user']['employeeId'];
        });
        print("EMPLOYEEEE ID: $employee_id");
      } else if (jsonResponse["success"] == false) {
        CustomSnackbar.show(context, "Failed to fetch User Profile. Please try again later.", "red");
      }
    } catch (e) {
      CustomSnackbar.show(context, "Something went wrong. Please try again later.", "red");
      print('Error in API call: $e');
    } finally {
      setState(() {
        isLoading = false; // Stop loading
      });
    }
  }

Future<void> verifyEmployee() async{
  setState(() {
    isLoading = true;
  });
  await getProfileData();
  try {
    final response = await apiService.postWithFile('verify', selectedImage!, bodyFields: {"employee_id": employee_id});
    // print(jsonDecode(response.body));
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status'] == 'Verified') {
      setState(() {
        isVerified = true;
      });
       print("IS VERIFIED 1: $isVerified");
      CustomSnackbar.show(context, "Employee Verification Successful!", "green");
      setState(() {
    isLoading = false;
  });
    }
    
    else {
      // setState(() {
      //   isVerified = false;
      // });
      setState(() {
    isLoading = false;
  });
      CustomSnackbar.show(context, "Employee Verification Failed!", "red");
    }
  }
  catch (e) {
    setState(() {
    isLoading = false;
  });
    debugPrint("Error in verify Employee API call: $e");
  }
}

 Future<void> getActiveStatus() async {
  try {
    final headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final response = await apiService.get(
      'get-is-active',
      headers: headers,
    );
    Map jsonResponse = jsonDecode(response.body);
    print(jsonResponse);

   if (jsonResponse['success']) {
  setState(() {
    isActive = jsonResponse['isActive'];
    });
}

 else if (jsonResponse["success"] == false) {
  debugPrint("Failed to fetch Active Status. Please try again later.");
    // CustomSnackbar.show(context, "Failed to fetch Active Status. Please try again later.", "red");
    }
  } catch (e) {
  debugPrint("Something went wrong. Please try again later.");
    // CustomSnackbar.show(context, "Something went wrong. Please try again later.", "red");
    print('Error in Active Status API call: $e');
  } finally {
    setState(() {
      isLoading = false; // Stop loading
    });
  }
}


Future<void> _pickImageFromCamera() async {
    final returnedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front, // Specify front camera
    );

    if (returnedImage != null) {
      setState(() {
        selectedImage = File(returnedImage.path);
      });
    }
  }


  void _updateTime() {
    setState(() {
      _timeString = _formatTime(DateTime.now());
      _dateString = _formatDate(DateTime.now());
    });
  }

  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

  String _formatDate(DateTime date) {
    return "${_getWeekday(date.weekday)}, ${_getMonth(date.month)} ${date.day}";
  }

  String _getWeekday(int weekday) {
    switch (weekday) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      default:
        return "";
    }
  }

  String _getMonth(int month) {
    switch (month) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
      default:
        return "";
    }
  }

  String formatCheckInTime(DateTime? dateTime) {
  if (dateTime == null) {
    return '--:--';
  }
  return DateFormat('HH:mm').format(dateTime);
}

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            width: screenWidth,
            height: screenHeight,
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
                Positioned(
                  top: 0,
                  left: 0,
                  bottom: 0,
                  right: 0,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        getCheckInCheckOutData();   
                                        getLocation();
                                        getLocationDetails(latitude, longitude);
                                        
                                        setState(() {
                                            
                                          });
            //                                   
                                      },
                                      icon: Icon(
                                        UIconsPro.boldRounded.refresh,
                                        size: 20,
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const NotificationPage()));
                                      },
                                      icon: Icon(
                                        UIconsPro.regularRounded.bell,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(bottom: screenHeight * .05),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        company,
                                        style: GoogleFonts.outfit(
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      Text(
                                        _timeString,
                                        style: GoogleFonts.outfit(
                                          height: 1,
                                          fontSize: 48,
                                          fontWeight: FontWeight.w600,
                                          color: const Color.fromRGBO(73, 84, 99, 1),
                                        ),
                                      ),
                                      Text(
                                        _dateString,
                                        style: GoogleFonts.outfit(
                                          fontSize: 24,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  flex: 7,
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxHeight: screenHeight * .37),
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                          child: Opacity(
                                            opacity: 0.06,
                                            child: Image.asset(
                                              "assets/images/map.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          left: 0,
                                          child: GestureDetector(
                                            onTap: _onTap,
                                            // onHorizontalDragEnd: (details) {
                                            //   if (details.primaryVelocity! > 0) {
                                            //     // Swiped right
                                            //     _onSwipe();
                                            //   } else if (details.primaryVelocity! <
                                            //       0) {
                                            //     // Swiped left
                                            //     _onSwipe();
                                            //   }
                                            // },
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child:
                                              AnimatedBuilder(
      animation: _flipAnimation,
      builder: (context, child) {
        final angle = _flipAnimation.value * 3.1416;
        final isFrontVisible = angle < 1.5708;

        return Transform(
          transform: Matrix4.rotationY(angle),
          alignment: Alignment.center,
          child: _playRippleAnimation
            ? RippleAnimation(
                repeat: false,
                minRadius: 75,
                ripplesCount: 4,
                duration: const Duration(seconds: 2),
                child: isFrontVisible
                  ? InHomeWidget(screenWidth: screenWidth)
                  : InOfficeWidget(formattedCounter: formattedCounter, screenWidth: screenWidth),
              )
            : isFrontVisible
              ? InHomeWidget(screenWidth: screenWidth)
              : InOfficeWidget(formattedCounter: formattedCounter, screenWidth: screenWidth),
        );
      },),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: Center(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      UIconsPro.solidRounded.marker,
                                                      color: const Color.fromRGBO(
                                                          73, 84, 99, 1),
                                                      size: 20,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Location: ",
                                                          style: GoogleFonts.outfit(
                                                              color:
                                                                  const Color.fromRGBO(
                                                                      73, 84, 99, 1),
                                                              fontSize: 15),
                                                        ),
                                                        Text(
                                                      (isInRange) ? "You are in Office reach" : "You are not in Office reach",
                                                      style: GoogleFonts.outfit(
                                                          color: (isInRange) ? Colors.green : Colors.red,
                                                              // const Color.fromRGBO(
                                                              //     73, 84, 99, 1),
                                                          fontSize: 15),
                                                    ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  cityName ?? "Unable to fetch Location",
                                                  style: GoogleFonts.outfit(
                                                      height: 1,
                                                      color: const Color.fromARGB(
                                                          255, 136, 148, 166),
                                                      fontSize: 13),
                                                ),
                                              ],
                                            ),
                                              
                                            
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: Center(
                                    child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/checkin.png",
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(
                                      formatCheckInTime(checkInTime),
                                      style: GoogleFonts.outfit(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Check in",
                                      style: GoogleFonts.outfit(
                                        height: 1,
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                )),
                              ),
                              Flexible(
                                child: Center(
                                    child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/checkout.png",
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(
                                      formatCheckInTime(checkOutTime),
                                      style: GoogleFonts.outfit(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Check Out",
                                      style: GoogleFonts.outfit(
                                        height: 1,
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                )),
                              ),
                              Flexible(
                                child: Center(
                                    child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/clockcheck.png",
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(
                                      workingHour ?? "--:--",
                                      style: GoogleFonts.outfit(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Working Hr's",
                                      style: GoogleFonts.outfit(
                                        height: 1,
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                )),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          if (isLoading) // Show loader when API is loading
          Container(
            color: Colors.black.withOpacity(0.5), // Darken background
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
}

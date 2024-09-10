// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:checkpoint/api/api_service.dart';
import 'package:checkpoint/widgets/circle_widgets/in_home_widget.dart';
import 'package:checkpoint/widgets/circle_widgets/in_office_widget.dart';
import 'package:checkpoint/views/notification.dart';
import 'package:checkpoint/widgets/background/background.dart';
import 'package:checkpoint/widgets/home_widgets/bottom_info.dart';
import 'package:checkpoint/widgets/home_widgets/dateAndTime.dart';
import 'package:checkpoint/widgets/home_widgets/location_text.dart';
import 'package:checkpoint/widgets/snackbar/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
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

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final String company = "GAIL Limited, Greater Noida Office";
  final String date = "";
  bool _playRippleAnimation = false; // Move this outside the build method
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;
  late AnimationController _controller;
  late Animation<double> _animation;
  Timer? _timer;
  bool isActive = false;
  File? selectedImage;
  double latitude = 0; // Current location latitude
  double longitude = 0; // Current location longitude
  // double targetLatitude = 28.4548039;
  // double targetLongitude = 77.5131496;

  double targetLatitude = 28.450371597622993;
  double targetLongitude = 77.58493137009076;

  double distanceInMeters = 0.0;
  bool isInRange = false;
  String? cityName;
  // bool inOffice = false;
  late String token = "";
  int _counter = 0;
  late Timer _workingTimer;
  String formattedCounter = "00:00:00";
  final ApiService apiService = ApiService();
  DateTime? checkInTime;
  DateTime? checkOutTime;
  late String? workingHour = "--:--";
  bool isLoading = true;
  late Map jwtDecodedToken = {};
  late String employee_id = "";
  late bool isVerified = true;
  bool _isCheckingInOut = false;

  DateTime? checkInStartTime;
  StreamSubscription<Position>? _positionStreamSubscription;

  bool isTimerPaused = false;
  DateTime? pauseStartTime;
  bool wasInRangeBeforePause = false;

  void _toggleTimer() {
    setState(() {
      if (isTimerPaused) {
        // Resuming the timer
        if (pauseStartTime != null) {
          Duration pauseDuration = DateTime.now().difference(pauseStartTime!);
          checkInStartTime = checkInStartTime?.add(pauseDuration);
        }
        isTimerPaused = false;
        pauseStartTime = null;
        _startTimer();
      } else {
        // Pausing the timer
        isTimerPaused = true;
        pauseStartTime = DateTime.now();
        wasInRangeBeforePause = isInRange;
        _workingTimer.cancel();
      }
    });
  }

  void _onRefresh() async {
    setState(() {
      isLoading = true;
    });

    // await getLocation();

    await getLocationDetails(latitude, longitude);
    await getCheckInCheckOutData();

    setState(() {
      isLoading = false;
    });
  }

  Future<void> getLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (mounted) {
      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
      });
    }

    calculateDistance();
  }

  void calculateDistance() async {
    distanceInMeters = Geolocator.distanceBetween(
        latitude, longitude, targetLatitude, targetLongitude);

    bool newIsInRange = distanceInMeters <= 200;
    if (newIsInRange != isInRange) {
      setState(() {
        isInRange = newIsInRange;
      });
      _handleLocationChange();
    }

    getLocationDetails(latitude, longitude);
    // Update the UI with the distance and range status
    debugPrint('Distance: $distanceInMeters meters');
    debugPrint(isInRange ? 'In range' : 'Not in range');
  }

  Future<void> getLocationDetails(
      double givenLatitude, double givenLongitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        givenLatitude,
        givenLongitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        // print(placemarks);
        setState(() {
          cityName =
              place.locality ?? 'Unknown'; // Update the instance variable
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

  Future<void> loadCheckInStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // inOffice = prefs.getBool('inOffice') ?? false;
    setState(() {
      isActive = prefs.getBool('isActive') ?? false;

      if (isActive) {
        _flipController.value = 1.0;

        String? storedStartTime = prefs.getString('checkInStartTime');
        if (storedStartTime != null) {
          checkInStartTime = DateTime.parse(storedStartTime);
          _startTimer();
        }
      } else {
        _flipController.value = 0.0;
      }
    });
  }

  void _startTimer() {
    _workingTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (checkInStartTime != null && !isTimerPaused) {
        Duration difference = DateTime.now().difference(checkInStartTime!);
        if (mounted) {
          setState(() {
            _counter = difference.inSeconds;
            formattedCounter = _formatDuration(difference);
          });
        }
      }
    });
  }

  Future<void> checkInOut(BuildContext context, String command) async {
    if (_isCheckingInOut) return;
    _isCheckingInOut = true;

    try {
      final Map<String, String> headers = {
        'Authorization': 'Bearer $token',
      };
      final response =
          await apiService.post(command, headers: headers, body: "");
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        if (command == 'checkin') {
          checkInStartTime = DateTime.now();
          await prefs.setString(
              'checkInStartTime', checkInStartTime!.toIso8601String());
          await prefs.setBool('isActive', true);
          setState(() {
            isActive = true;
            isTimerPaused = false;
            pauseStartTime = null;
          });
          _startTimer();
          _flipController.forward();
        } else {
          await prefs.remove('checkInStartTime');
          await prefs.setBool('isActive', false);
          setState(() {
            isActive = false;
            _counter = 0;
            formattedCounter = "00:00:00";
            checkInStartTime = null;
            isTimerPaused = false;
            pauseStartTime = null;
          });
          _workingTimer.cancel();
          _flipController.reverse();
        }
        CustomSnackbar.show(
            context,
            (command == 'checkin')
                ? "Check-in Successful."
                : "Check-out Successful.",
            "green");
      } else {
        CustomSnackbar.show(
            context, "Failed to $command. Please try again later.", "red");
      }
    } catch (e) {
      CustomSnackbar.show(
          context, "Something went wrong. Please try again later.", "red");
      debugPrint(e.toString());
    } finally {
      _isCheckingInOut = false;
    }
  }

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
          checkInTime = jsonResponse.containsKey('checkInTime') &&
                  jsonResponse['checkInTime'] != null
              ? DateTime.parse(jsonResponse['checkInTime'])
                  .toUtc()
                  .add(Duration(hours: 5, minutes: 30))
              : null;

          checkOutTime = jsonResponse.containsKey('checkOutTime') &&
                  jsonResponse['checkOutTime'] != null
              ? DateTime.parse(jsonResponse['checkOutTime'])
                  .toUtc()
                  .add(Duration(hours: 5, minutes: 30))
              : null;

          if (jsonResponse.containsKey('totalWorkingHours') &&
              jsonResponse['totalWorkingHours'] != null) {
            double hours =
                double.parse(jsonResponse['totalWorkingHours'].toString());
            int totalMinutes = (hours * 60).toInt();
            int hoursPart = totalMinutes ~/ 60;
            int minutesPart = totalMinutes % 60;

            workingHour =
                '${hoursPart.toString().padLeft(2, '0')}:${minutesPart.toString().padLeft(2, '0')}';
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
        CustomSnackbar.show(context,
            "Failed to fetch working hours. Please try again later.", "red");
      }
    } catch (e) {
      CustomSnackbar.show(
          context, "Something went wrong. Please try again later.", "red");
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
        CustomSnackbar.show(context,
            "Failed to fetch User Profile. Please try again later.", "red");
      }
    } catch (e) {
      CustomSnackbar.show(
          context, "Something went wrong. Please try again later.", "red");
      print('Error in API call: $e');
    } finally {
      setState(() {
        isLoading = false; // Stop loading
      });
    }
  }

  Future<void> verifyEmployee() async {
    setState(() {
      isLoading = true;
    });
    await getProfileData();
    try {
      final response = await apiService.postWithFile('verify', selectedImage!,
          bodyFields: {"employee_id": employee_id});
      // print(jsonDecode(response.body));
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'] == 'Verified') {
        setState(() {
          isVerified = true;
        });
        print("IS VERIFIED 1: $isVerified");
        CustomSnackbar.show(
            context, "Employee Verification Successful!", "green");
        setState(() {
          isLoading = false;
        });
      } else {
        // setState(() {
        //   isVerified = false;
        // });
        setState(() {
          isLoading = false;
        });
        CustomSnackbar.show(context, "Employee Verification Failed!", "red");
      }
    } catch (e) {
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
      } else if (jsonResponse["success"] == false) {
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

  // Future<void> _pickImageFromCamera() async {
  //   final returnedImage = await ImagePicker().pickImage(
  //     source: ImageSource.camera,
  //     preferredCameraDevice: CameraDevice.front, // Specify front camera
  //   );

  //   if (returnedImage != null) {
  //     setState(() {
  //       selectedImage = File(returnedImage.path);
  //     });
  //   }
  // }

  String formatCheckInTime(DateTime? dateTime) {
    if (dateTime == null) {
      return '--:--';
    }
    return DateFormat('HH:mm').format(dateTime);
  }

  void _triggerWobble() {
    _controller.forward().then((_) {
      _controller.reverse();
    });
  }

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(_flipController);

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: -10.0, end: 10.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticIn),
    );
    _startLocationMonitoring();
    // getLocation();
    getTokenFromPrefs();
    loadCheckInStatus();
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    _flipController.dispose();
    _controller.dispose();
    _workingTimer.cancel();
    _timer!.cancel();
    super.dispose();
  }

  void _startLocationMonitoring() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    _positionStreamSubscription =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
      });
      calculateDistance();
      _handleLocationChange();
    });
  }

  DateTime? _lastLocationChangeTime;
  final _locationChangeCooldown = Duration(minutes: 5);

  void _handleLocationChange() {
    final now = DateTime.now();
    if (_lastLocationChangeTime == null ||
        now.difference(_lastLocationChangeTime!) > _locationChangeCooldown) {
      if (isInRange && !isActive && !isTimerPaused) {
        checkInOut(context, "checkin");
      } else if (!isInRange && isActive && !isTimerPaused) {
        checkInOut(context, "checkout");
      } else if (isInRange && isTimerPaused && wasInRangeBeforePause) {
        // Auto-resume when coming back in range
        _toggleTimer();
      }
      _lastLocationChangeTime = now;
    }
  }

  void _onTap() async {
    if (isInRange) {
      if (!_flipController.isAnimating) {
        setState(() {
          _playRippleAnimation = true;
        });

        Timer(const Duration(seconds: 2), () {
          setState(() {
            _playRippleAnimation = false;
          });
        });

        // Handle check-in and check-out logic
        // if (!isActive) {
        //   if (isVerified) {
        //     checkInOut(context, "checkin");
        //   } else {
        //     setState(() {
        //       _playRippleAnimation = false;
        //     });
        //   }
        // } else {
        //   checkInOut(context, "checkout");
        // }
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
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: _onRefresh,
                                      icon: Icon(
                                        UIconsPro.boldRounded.refresh,
                                        size: 20,
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const NotificationPage()));
                                      },
                                      icon: Icon(
                                        UIconsPro.regularRounded.bell,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  company,
                                  style: GoogleFonts.outfit(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                                const Spacer(),
                                const Dateandtime(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * .02,
                          ),
                          Expanded(
                            flex: 5,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Opacity(
                                    opacity: 0.18,
                                    child: Image.asset(
                                      "assets/images/map1.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 5,
                                  bottom: 20,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 8,
                                        child: Center(
                                          child: GestureDetector(
                                            onTap: isInRange
                                                ? _onTap
                                                : _triggerWobble,
                                            child: AnimatedBuilder(
                                              animation: Listenable.merge(
                                                  [_flipAnimation, _animation]),
                                              builder: (context, child) {
                                                final angle =
                                                    _flipAnimation.value *
                                                        3.1416;
                                                final isFrontVisible =
                                                    angle < 1.5708;
                                                return isInRange
                                                    ? Transform(
                                                        transform:
                                                            Matrix4.rotationY(
                                                                angle),
                                                        alignment:
                                                            Alignment.center,
                                                        child: _playRippleAnimation
                                                            ? RippleAnimation(
                                                                color: Colors.black45,
                                                                repeat: false,
                                                                minRadius: 75,
                                                                ripplesCount: 4,
                                                                duration: const Duration(seconds: 2),
                                                                child: isFrontVisible
                                                                    ? InHomeWidget(screenWidth: screenWidth, inRange: isInRange)
                                                                    : InOfficeWidget(
                                                                        formattedCounter:
                                                                            formattedCounter,
                                                                        screenWidth:
                                                                            screenWidth,
                                                                        onPlayPauseTap:
                                                                            _toggleTimer,
                                                                        isPaused:
                                                                            isTimerPaused,
                                                                        inRange:
                                                                            isInRange,
                                                                      ))
                                                            : isFrontVisible
                                                                ? InHomeWidget(
                                                                    screenWidth:
                                                                        screenWidth,
                                                                    inRange:
                                                                        isInRange,
                                                                  )
                                                                : InOfficeWidget(
                                                                    formattedCounter:
                                                                        formattedCounter,
                                                                    screenWidth:
                                                                        screenWidth,
                                                                    onPlayPauseTap:
                                                                        _toggleTimer,
                                                                    isPaused:
                                                                        isTimerPaused,
                                                                    inRange:
                                                                        isInRange,
                                                                  ))
                                                    : Transform.translate(
                                                        offset: Offset(_animation.value, 0),
                                                        child: isFrontVisible
                                                            ? InHomeWidget(
                                                                screenWidth:
                                                                    screenWidth,
                                                                inRange:
                                                                    isInRange,
                                                              )
                                                            : InOfficeWidget(
                                                                formattedCounter:
                                                                    formattedCounter,
                                                                screenWidth:
                                                                    screenWidth,
                                                                onPlayPauseTap:
                                                                    _toggleTimer,
                                                                isPaused:
                                                                    isTimerPaused,
                                                                inRange:
                                                                    isInRange,
                                                              ));
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Locationtext(
                                              isInRange: isInRange,
                                              cityName: cityName),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Bottominfo(
                                  checkin: formatCheckInTime(checkInTime),
                                  checkout: formatCheckInTime(checkOutTime),
                                  workingHour: workingHour),
                            ),
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

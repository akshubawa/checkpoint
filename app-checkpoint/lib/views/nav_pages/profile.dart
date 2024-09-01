import 'dart:convert';
import 'package:checkpoint/api/api_service.dart';
import 'package:checkpoint/screen/ui/screen.dart';
import 'package:checkpoint/views/auth/login_view.dart';
import 'package:checkpoint/widgets/circular_icons.dart';
import 'package:checkpoint/widgets/side_menu_tile.dart';
import 'package:checkpoint/widgets/snackbar/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/background/background.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _version = "Loading";
  bool isLoading = true;
  late String token = "";
  late String userName = "Loading...";
  late String departmentName = "Loading...";
  final ApiService apiService = ApiService();
  late Map userDetails = {};

  Future<void> _getVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        _version = packageInfo.version;
      });
    } catch (e) {
      debugPrint("Error getting package info: $e");
    }
  }

  void logout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    CustomSnackbar.show(context, "Logged out successfully", "green");

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }

  void getTokenFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? storedToken = prefs.getString('token');
    if (storedToken != null) {
      setState(() {
        token = storedToken;
      });
      getProfileData();
    }
  }

  String capitalizeWords(String input) {
  return input.split(' ').map((word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join(' ');
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
          userDetails = jsonResponse['user'];
          userName = "${userDetails['firstName']} ${userDetails['lastName']}";
          departmentName = capitalizeWords(userDetails['departmentName'] ?? 'Unknown');

        });
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

  @override
  void initState() {
    _getVersion();
    getTokenFromPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
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
          SafeArea(
            child: isLoading
                ? const Center(child: CircularProgressIndicator()) // Show loader while loading
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        const Text(
                          'Profile',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            'https://img.freepik.com/free-photo/portrait-man-laughing_23-2148859448.jpg?size=338&ext=jpg&ga=GA1.1.2008272138.1724889600&semt=ais_hybrid',
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          userName, // Use the fetched user's name
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          departmentName,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: CircularIcons(
                                    icon: Icons.people_alt_rounded,
                                    label: 'My Team',
                                    color: Colors.blue),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const Screen(initialPage: 1),
                                      ),
                                    );
                                  },
                                  child: const CircularIcons(
                                      icon: Icons.calendar_month_rounded,
                                      label: 'Attendence',
                                      color: Colors.purple),
                                ),
                              ),
                              const Expanded(
                                child: CircularIcons(
                                    icon: Icons.settings,
                                    label: 'Settings',
                                    color: Colors.orange),
                              ),
                              const Expanded(
                                child: CircularIcons(
                                    icon: Icons.person,
                                    label: 'My Profile',
                                    color: Colors.blueAccent),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        Column(
                          children: [
                            SideMenuTile(
                              title: "Notifications",
                              icon: Icons.notifications_active,
                              onTap: () {},
                            ),
                            SideMenuTile(
                              title: "My Leaves",
                              icon: Icons.medical_services_rounded,
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const Screen(initialPage: 2),
                                  ),
                                );
                              },
                            ),
                            SideMenuTile(
                              title: "Customer Support",
                              icon: Icons.support_agent_rounded,
                              onTap: () {},
                            ),
                            SideMenuTile(
                              title: "Logout",
                              icon: Icons.logout,
                              onTap: () {
                                logout(context);
                              },
                            ),
                            const Divider(
                              color: Colors.grey,
                              height: 1,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Version: $_version",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 14),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 100,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

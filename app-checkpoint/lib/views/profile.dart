import 'package:checkpoint/widgets/circular_icons.dart';
import 'package:checkpoint/widgets/side_menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Profile extends StatefulWidget {

  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _version = "Loading";

  Future<void> _getVersion() async {
  try {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // print("PackageInfo: ${packageInfo.version}");
    setState(() {
      _version = packageInfo.version;
    });
  } catch (e) {
    debugPrint("Error getting package info: $e");
  }
}


  @override
  void initState() {
    _getVersion();
    super.initState();
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Profile Image and Name
            const CircleAvatar(
              radius: 50, // Adjust the size as needed
              backgroundImage: NetworkImage(
                'https://img.freepik.com/free-photo/portrait-man-laughing_23-2148859448.jpg?size=338&ext=jpg&ga=GA1.1.2008272138.1724889600&semt=ais_hybrid', // Replace with your image URL
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Akshay Negi',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const Text(
              'Director Business Development',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
        
            // Icons with Text
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CircularIcons(icon: Icons.people_alt_rounded, label: 'My Team', color: Colors.blue),
                  ),
                  
                  Expanded(
                    child: CircularIcons(icon: Icons.calendar_month_rounded, label: 'Attendence', color: Colors.purple),
                  ),
                  Expanded(
                    child: CircularIcons(icon: Icons.settings, label: 'Settings', color: Colors.orange),
                  ),
                  Expanded(
                    child: CircularIcons(icon: Icons.person, label: 'My Profile', color: Colors.blueAccent),
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
                    onTap: () {
                     
                    },
                  ),
                  SideMenuTile(
                    title: "My Leaves",
                    icon: Icons.medical_services_rounded,
                    onTap: () {
                     
                    },
                  ),
                  SideMenuTile(
                    title: "Customer Support",
                    icon: Icons.support_agent_rounded,
                    onTap: () {
                     
                    },
                  ),
                  SideMenuTile(
                    title: "Logout",
                    icon: Icons.logout,
                    onTap: () {
                     
                    },
                  ),
                 
                 const Divider(
          color: Colors.grey,
          height: 1,
        ),
                const SizedBox(
                  height: 10,
                ),
        
                //Footer
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
    );
  }
}

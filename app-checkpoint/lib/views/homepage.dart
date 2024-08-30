import 'package:checkpoint/views/geofencing/check_location.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to the Homepage!'),
            TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> const CheckLocationView()));}, child: Text("Check Distance"))
          ],
        ),
      ),
    );
  }
}
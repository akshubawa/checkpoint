import 'package:checkpoint/screen/ui/screen.dart';
import 'package:checkpoint/views/auth/login_view.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class MyApp extends StatelessWidget {
  final String token;
  const MyApp({super.key, required this.token});
  @override
  Widget build(BuildContext context) {
     bool isLoggedIn = token != "" && !JwtDecoder.isExpired(token);
    return MaterialApp(
      title: 'Checkpoint',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const Screen() : const LoginPage(),

    );
  }
}

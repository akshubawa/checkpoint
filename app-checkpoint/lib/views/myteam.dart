import 'package:flutter/material.dart';

class Myteam extends StatelessWidget {
  const Myteam({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Team', style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
    );
  }
}

// import 'dart:async';
// import 'dart:io';

// import 'package:checkpoint/views/my_map_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class GeofencingView extends StatefulWidget {
//   const GeofencingView({super.key});

//   @override
//   State<GeofencingView> createState() => _GeofencingViewState();
// }

// class _GeofencingViewState extends State<GeofencingView> {
//   static const locationChannel = MethodChannel("locationPermissionPlatform");
//   final _eventChannel = const EventChannel("com.app.checkpoint");
//   StreamSubscription? subscription;
//   bool isPermissionGranted = false;

//   @override
//   void initState() {
//     subscription = _eventChannel.receiveBroadcastStream().listen((dynamic event){
//       print("Received: $event");
//     },
//     onError: (dynamic error){
//       print("Received Error: $error");
//     }
//     );
//     super.initState();
//   }

//   @override
//   void dispose() {
//     subscription?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: SafeArea(child: Platform.isAndroid ? Column(children: [
//         TextButton(onPressed: ()async{
//           try{
//             bool data = await locationChannel.invokeMethod('getLocationPermission');
//             setState(() {
//               isPermissionGranted = data;
//             });
//           } on PlatformException catch(e) {
//             debugPrint("Fail: ${e.message}");
//           }
//         }, child: Text("Get Location Permission"),), isPermissionGranted ? SizedBox(
//         width: width,
//         height: height / 1.2,
//         child: const MyMapsView(),
//       ): const SizedBox()
//       ],): SizedBox(
//         width: width,
//         height: height / 1.5,
//         child: const MyMapsView(),
//       )),
//     );
//   }
// }
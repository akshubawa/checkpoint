// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class MyMapsView extends StatefulWidget {
//   const MyMapsView({super.key});

//   @override
//   State<MyMapsView> createState() => _MyMapsViewState();
// }

// class _MyMapsViewState extends State<MyMapsView> {
//   final channel = const MethodChannel('myMapsView');

//   @override
//   Widget build(BuildContext context) {
//     return Platform.isAndroid ? AndroidView(viewType: myMapsView,
//     layoutDirection: TextDirection.ltr,
//     creationParams: null,
//     creationParamsCodec: const StandardMessageCodec(),
//     onPlatformViewCreated: _onPlatformViewCreated,
//     ): UiKitView(viewType: myMapsView,
//      layoutDirection: TextDirection.ltr,
//     creationParams: null,
//     creationParamsCodec: const StandardMessageCodec(),
//     onPlatformViewCreated: _onPlatformViewCreated,
//     );
//   }

//   void _onPlatformViewCreated(int viewId) {
//    channel.setMethodCallHandler(_handleMethod);
//   }

//   Future<dynamic> _handleMethod(MethodCall call) async{
//     switch(call.method) {
//       case 'sendFromNative':
//         String text = call.arguments as String;
//         debugPrint("Text is $text");
//     }
//   } 
// }
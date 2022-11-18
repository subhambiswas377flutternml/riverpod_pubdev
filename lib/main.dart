import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_poc/homepage.dart';
import 'package:flutter/services.dart';

 class MyHttpOverrides extends HttpOverrides{
      @override
      HttpClient createHttpClient(SecurityContext? context){
        return super.createHttpClient(context)
          ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
      }
}
    
void main()
{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
  SystemUiOverlay.bottom
]);
HttpOverrides.global =  MyHttpOverrides();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget
{
  const MyApp({Key? key}):super(key: key); 

  @override 
  Widget build(BuildContext context)
  {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
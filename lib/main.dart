import 'package:flutter/material.dart';
import 'package:gearbo/provider/room_provider.dart';
import 'package:gearbo/provider/user_provider.dart';
import 'package:gearbo/screens/landing_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=> UserProvider()),
          ChangeNotifierProvider(create: (_)=> RoomProvider()),
        ],
            child: const MyApp()),

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner:  false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home:  LandingPage(),
    );
  }
}

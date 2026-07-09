import 'package:flutter/material.dart';
import 'package:paranubhutifoundation/config/routes/routes_name.dart';
import 'package:paranubhutifoundation/features/home/presentation/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      initialRoute: RoutesNames.homescreen,
      routes: RoutesNames.routes,
    );

  }
}

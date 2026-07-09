import 'package:flutter/material.dart';
import 'package:paranubhutifoundation/config/constants/app_constant.dart';
import 'package:paranubhutifoundation/shared/widgets/bottam_navigation_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppConstants.appName),
      titleTextStyle: TextStyle(
      fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black),
            iconTheme: IconThemeData(color: Colors.white),
      ),
      bottomNavigationBar: BottamNavigationScreen(selectindex: 0,),
      body: Column(
        children: [
          Text("Home page")
        ],
      ),
    );
  }
}

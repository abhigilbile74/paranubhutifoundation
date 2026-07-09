import 'package:flutter/material.dart';
import 'package:paranubhutifoundation/shared/widgets/appbar_screen.dart';
import 'package:paranubhutifoundation/shared/widgets/bottam_navigation_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(centerTitle: false),

      bottomNavigationBar: BottamNavigationScreen(selectindex: 0,),
      body: Column(
        children: [
          Text("Home page")
        ],
      ),
    );
  }
}

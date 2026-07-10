import 'package:flutter/material.dart';
import 'package:paranubhutifoundation/config/constants/app_constant.dart';
import 'package:paranubhutifoundation/config/routes/routes_name.dart';

AppBar buildAppBar({
  String? title,
  bool centerTitle = true,
  bool showBackButton = false,
  List<Widget>? actions,
}) {
  return AppBar(
    automaticallyImplyLeading: showBackButton,
    elevation: 0,
    centerTitle: centerTitle,
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.black,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromARGB(255, 238, 239, 240), Color.fromARGB(255, 147, 199, 241)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    ),
    title: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          tooltip: "Donate",
          icon: const Icon(Icons.volunteer_activism, color: Colors.redAccent),
          onPressed: () {
            // Navigate to Donation Screen
            RoutesNames.homescreen;
          },
        ),

        Text(
          title ?? AppConstants.appName,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5,
            color: Color.fromARGB(255, 19, 20, 19),
          ),
        ),
      ],
    ),
    actions:
        actions ??
        [
          const SizedBox(width: 8),
          IconButton(onPressed: () {}, icon: Icon(Icons.notification_add)),
          const SizedBox(width: 8),
        ],
  );
}

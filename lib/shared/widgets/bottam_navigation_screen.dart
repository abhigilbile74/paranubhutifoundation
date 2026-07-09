import 'package:flutter/material.dart';
import 'package:paranubhutifoundation/config/routes/routes_name.dart';

class BottamNavigationScreen extends StatelessWidget {
  final int selectindex;
  const BottamNavigationScreen({super.key, required this.selectindex});

  void _navigate(BuildContext context, int index) {
    if (index == selectindex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, RoutesNames.homescreen);
        break;

      case 1:
        Navigator.pushReplacementNamed(context, RoutesNames.donate);
        break;

      case 2:
        Navigator.pushReplacementNamed(context, RoutesNames.volunter);
        break;

      case 3:
        Navigator.pushReplacementNamed(context, RoutesNames.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF1976D2);
    const Color lightBlue = Color(0xFFE3F2FD);
    const Color indicatorBlue = Color(0xFF90CAF9);
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: lightBlue,
            indicatorColor: indicatorBlue.withValues(alpha: 0.35),
            iconTheme: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return const IconThemeData(color: primaryBlue, size: 28);
              }
              return const IconThemeData(color: Colors.grey, size: 24);
            }),
            labelTextStyle: WidgetStateProperty.resolveWith((states) {
              return TextStyle(
                color: states.contains(WidgetState.selected)
                    ? primaryBlue
                    : Colors.grey.shade700,
                fontWeight: states.contains(WidgetState.selected)
                    ? FontWeight.w600
                    : FontWeight.w500,
                fontSize: 12,
              );
            }),
          ),
          child: NavigationBar(
            selectedIndex: selectindex,
            height: 72,
            elevation: 0,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,

            onDestinationSelected: (index) {
              _navigate(context, index);
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_filled),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.abc_rounded),
                label: 'Donate',
              ),
              NavigationDestination(
                icon: Icon(Icons.abc_outlined),
                label: 'Volunter',
              ),
              NavigationDestination(
                icon: Icon(Icons.portable_wifi_off_outlined),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

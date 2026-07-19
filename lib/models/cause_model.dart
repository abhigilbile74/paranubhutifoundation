import 'package:flutter/material.dart';

/// Model for a cause category shown on the Donate and Causes screens.
class CauseModel {
  final String id;
  final String title;
  final String? description;
  final IconData icon;
  final Color badgeColor;

  const CauseModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.badgeColor,
    this.description,
  });
}
import 'package:flutter/material.dart';

class OnboardingGoalModel {
  final String id;
  final Map<String, String> title;
  final Map<String, String> subtitle;
  final String icon;

  OnboardingGoalModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  static const Map<String, IconData> iconMap = {
    'fitness_center': Icons.fitness_center,
    'shopping_bag_outlined': Icons.shopping_bag_outlined,
    'directions_run': Icons.directions_run,
  };

  IconData get iconData => iconMap[icon] ?? Icons.star;

  factory OnboardingGoalModel.fromMap(Map<String, dynamic> map, String id) {
    return OnboardingGoalModel(
      id: id,
      title: Map<String, String>.from(map['title'] ?? {}),
      subtitle: Map<String, String>.from(map['subtitle'] ?? {}),
      icon: map['icon'] ?? 'fitness_center',
    );
  }
}
import 'package:flutter/material.dart';

import '../../../../generated/app_strings.dart';


enum TipCategory { training, nutrition, recovery, mindset, lifestyle, saved }

extension TipCategoryExtension on TipCategory {
  String get labelKey {
    switch (this) {
      case TipCategory.training:  return AppStrings.training;
      case TipCategory.nutrition: return AppStrings.nutrition;
      case TipCategory.recovery:  return AppStrings.recovery;
      case TipCategory.mindset:   return AppStrings.mindset;
      case TipCategory.lifestyle: return AppStrings.lifestyle;
      case TipCategory.saved:     return AppStrings.saved;
    }
  }

  IconData get icon {
    switch (this) {
      case TipCategory.training:  return Icons.fitness_center_rounded;
      case TipCategory.nutrition: return Icons.restaurant_rounded;
      case TipCategory.recovery:  return Icons.bedtime_rounded;
      case TipCategory.mindset:   return Icons.psychology_rounded;
      case TipCategory.lifestyle: return Icons.wb_sunny_rounded;
      case TipCategory.saved:     return Icons.bookmark_rounded;
    }
  }

  Color get bgColor {
    switch (this) {
      case TipCategory.training:  return const Color(0xFFEAF3DE);
      case TipCategory.nutrition: return const Color(0xFFE6F1FB);
      case TipCategory.recovery:  return const Color(0xFFEEEDFE);
      case TipCategory.mindset:   return const Color(0xFFFAEEDA);
      case TipCategory.lifestyle: return const Color(0xFFFAECE7);
      case TipCategory.saved:     return const Color(0xFFF1EFE8);
    }
  }

  Color get iconColor {
    switch (this) {
      case TipCategory.training:  return const Color(0xFF3B6D11);
      case TipCategory.nutrition: return const Color(0xFF185FA5);
      case TipCategory.recovery:  return const Color(0xFF534AB7);
      case TipCategory.mindset:   return const Color(0xFF854F0B);
      case TipCategory.lifestyle: return const Color(0xFF993C1D);
      case TipCategory.saved:     return const Color(0xFF5F5E5A);
    }
  }

  Color get tagBg {
    switch (this) {
      case TipCategory.training:  return const Color(0xFFC0DD97);
      case TipCategory.nutrition: return const Color(0xFFB5D4F4);
      case TipCategory.recovery:  return const Color(0xFFCECBF6);
      case TipCategory.mindset:   return const Color(0xFFFAC775);
      case TipCategory.lifestyle: return const Color(0xFFF5C4B3);
      case TipCategory.saved:     return const Color(0xFFD3D1C7);
    }
  }

  Color get tagTextColor {
    switch (this) {
      case TipCategory.training:  return const Color(0xFF173404);
      case TipCategory.nutrition: return const Color(0xFF042C53);
      case TipCategory.recovery:  return const Color(0xFF26215C);
      case TipCategory.mindset:   return const Color(0xFF412402);
      case TipCategory.lifestyle: return const Color(0xFF4A1B0C);
      case TipCategory.saved:     return const Color(0xFF444441);
    }
  }
}

class TipModel {
  final TipCategory category;
  final String titleKey;
  final String descKey;

  const TipModel({
    required this.category,
    required this.titleKey,
    required this.descKey,
  });
}
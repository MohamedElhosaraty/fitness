import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'custom_day_item.dart';

class CustomSelectDay extends StatefulWidget {
  const CustomSelectDay({super.key});

  @override
  State<CustomSelectDay> createState() => _CustomSelectDayState();
}

class _CustomSelectDayState extends State<CustomSelectDay> {
  int _selectedDays = 1;

  @override
  Widget build(BuildContext context) {
    final List<String> days = [
      'days_2'.tr(),
      'days_3'.tr(),
      'days_4'.tr(),
      'days_5'.tr(),
    ];

    return Row(
      children: List.generate(
        days.length,
            (index) => CustomDayItem(
          label: days[index],
          isSelected: _selectedDays == index,
          onTap: () => setState(() => _selectedDays = index),
        ),
      ),
    );
  }
}
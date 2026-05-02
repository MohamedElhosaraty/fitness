import 'package:flutter/material.dart';

import '../../../../core/helpers/user_preferences.dart';
import '../../../../core/localization/localization_methods.dart';
import 'custom_day_item.dart';

class CustomSelectDay extends StatefulWidget {
  const CustomSelectDay({super.key});

  @override
  State<CustomSelectDay> createState() => _CustomSelectDayState();
}

class _CustomSelectDayState extends State<CustomSelectDay> {
  int _selectedDays = 1;

  @override
  void initState() {
    super.initState();
    UserPreferences.setNumberDays = 3;
  }

  @override
  Widget build(BuildContext context) {
    final List<String> days = [
      tr(context, 'days_2'),
      tr(context, 'days_3'),
      tr(context, 'days_4'),
      tr(context, 'days_5'),
    ];

    return Row(
      children: List.generate(
        days.length,
            (index) => CustomDayItem(
          key: Key('dayItem_$index'),
          label: days[index],
              itemIndex: index,
              isSelected: _selectedDays == index,
          onTap: () {
            setState(() => _selectedDays = index);
            UserPreferences.setNumberDays = index + 2;
          },
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../../../core/helpers/user_preferences.dart';
import '../../../../core/localization/localization_methods.dart';
import '../../../../generated/app_strings.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      UserPreferences.setNumberDays = 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> days = [
      tr(context, AppStrings.days2),
      tr(context, AppStrings.days3),
      tr(context, AppStrings.days4),
      tr(context, AppStrings.days5),
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
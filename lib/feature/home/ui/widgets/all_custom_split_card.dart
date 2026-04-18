import 'package:fitness/core/helpers/extensions.dart';
import 'package:fitness/feature/home/domain/entity/list_split_card_data.dart';
import 'package:fitness/feature/home/ui/widgets/custom_split_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routing/routes.dart';
import '../../domain/entity/training_split_type.dart';

class AllCustomSplitCard extends StatefulWidget {
  const AllCustomSplitCard({super.key});

  @override
  State<AllCustomSplitCard> createState() => _AllCustomSplitCardState();
}

class _AllCustomSplitCardState extends State<AllCustomSplitCard> {

  TrainingSplitType? selectedSplit;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listSplitCardData.length,
      separatorBuilder: (_, __) => 16.verticalSpace,
      itemBuilder: (_, i) {
        final split = listSplitCardData[i];
        return InkWell(
          onTap: () {
            setState(() => selectedSplit = split.type);
            context.pushNamed(Routes.weeklyScheduleScreen, arguments: split.type);
          },
          child: CustomSplitCard(
            isSelected: selectedSplit == split.type,
            title: split.title,
            subtitle: split.subtitle,
            buttons: split.buttons,
          ),
        );
      },
    );
  }
}

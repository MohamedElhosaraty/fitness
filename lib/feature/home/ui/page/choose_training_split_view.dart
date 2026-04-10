import 'package:fitness/feature/home/ui/widgets/all_custom_split_card.dart';
import 'package:fitness/feature/home/ui/widgets/custom_choose_training_card.dart';
import 'package:fitness/feature/home/ui/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChooseTrainingSplitView extends StatelessWidget {
  const ChooseTrainingSplitView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              const CustomAppBar(
                title: "Choose Training Split",),
              20.verticalSpace,
              const CustomChooseTrainingCard(),
              20.verticalSpace,
              const AllCustomSplitCard(),
              20.verticalSpace,
            ],
          ),
        ),
    );
  }
}




import 'package:fitness/feature/home/ui/widgets/custom_exercise_card.dart';
import 'package:fitness/feature/home/ui/widgets/custom_select_exercises_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/custom_button.dart';
import '../widgets/custom_app_bar.dart';

class Exercise {
  final String name;
  final String muscle;
  bool isSelected;

  Exercise({
    required this.name,
    required this.muscle,
    this.isSelected = false,
  });
}

class SelectExercisesView extends StatefulWidget {
  const SelectExercisesView({super.key});

  @override
  State<SelectExercisesView> createState() => _SelectExercisesViewState();
}

class _SelectExercisesViewState extends State<SelectExercisesView> {
  final List<Exercise> exercises = [
    Exercise(name: "Squat", muscle: "Quads",),
    Exercise(name: "Leg Press", muscle: "Quads", ),
    Exercise(name: "Romanian Deadlift", muscle: "Hamstrings"),
    Exercise(name: "Leg Curl", muscle: "Hamstrings"),
  ];

  int get selectedCount =>
      exercises.where((e) => e.isSelected).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
               CustomAppBar(
                   title: "Select Exercises"),
               CustomSelectExercisesHeader(
                   selectedCount: selectedCount),
               16.verticalSpace,
               Expanded(
                child: ListView.separated(
                  itemCount: exercises.length,
                  separatorBuilder: (_, __) => 12.verticalSpace,
                  itemBuilder: (context, index) {
                    final exercise = exercises[index];
                    return CustomExercisesCard(
                      exercise: exercise,
                      onTap: () {
                        setState(() {
                          exercise.isSelected = !exercise.isSelected;
                        });
                      },
                    );
                  },
                ),
              ),
              CustomButton(
                yPadding: 15.sp,
                  onPressed: (){},
                  text: "Done ($selectedCount)exercises",
              )

            ],
          ),
        ),
      ),
    );
  }

}


import 'package:fitness/feature/home/ui/cubit/get_day_exercises/get_day_exercises_cubit.dart';
import 'package:fitness/feature/home/ui/widgets/custom_exercise_card.dart';
import 'package:fitness/feature/home/ui/widgets/custom_select_exercises_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/toast_helper.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../data/model/weekly_schedule_model.dart';
import '../cubit/add_exercises/add_exercises_cubit.dart';
import '../cubit/get_exercises/get_exercises_cubit.dart';
import '../widgets/custom_app_bar.dart';

class SelectExercisesView extends StatelessWidget {
  const SelectExercisesView({super.key, required this.daySchedule});

  final DaySchedule daySchedule;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: BlocBuilder<GetExercisesCubit, GetExercisesState>(
          builder: (context, state) {
            if (state is GetExercisesLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is GetExercisesError) {
              return Center(child: Text(state.message));
            }
            if (state is GetExercisesSuccess) {
              final exercises = state.exercises;
              final selectedCount = exercises.where((e) => e.isSelected).length;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const CustomAppBar(title: "Select Exercises"),
                    CustomSelectExercisesHeader(
                      selectedCount: selectedCount,
                      daySchedule: daySchedule,
                    ),
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
                              context
                                  .read<GetExercisesCubit>()
                                  .toggleExercise(exercise);
                            },
                          );
                        },
                      ),
                    ),
                    20.verticalSpace,
                    if (selectedCount > 0)
                      BlocConsumer<AddExercisesCubit, AddExercisesState>(
                        listener: (context, state) {
                          if (state is AddExercisesSuccess) {
                            ToastHelper().showSuccessToast(
                                context, "Exercises added successfully");
                            context
                                .read<GetDayExercisesCubit>()
                                .getDayExercises(
                                dayName: daySchedule.dayName);
                            Navigator.pop(context);
                          }
                          if (state is AddExercisesError) {
                            ToastHelper()
                                .showErrorToast(context, state.message);
                          }
                        },
                        builder: (context, state) {
                          return CustomButton(
                            yPadding: 15.sp,
                            isLoading: state is AddExercisesLoading,
                            onPressed: () {
                              final selected = exercises
                                  .where((e) => e.isSelected)
                                  .toList();

                              // copyWith بدل التعديل المباشر
                              final updatedDay = daySchedule.copyWith(
                                exercises: selected,
                              );

                              context
                                  .read<AddExercisesCubit>()
                                  .addExercises(day: updatedDay);
                            },
                            text: "Done ($selectedCount) exercises",
                          );
                        },
                      ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
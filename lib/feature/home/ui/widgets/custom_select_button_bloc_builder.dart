import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/toast_helper.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../data/model/day_schedule_model.dart';
import '../../data/model/exercise_model.dart';
import '../cubit/add_exercises/add_exercises_cubit.dart';
import '../cubit/get_all_day_exercises/get__all_day_exercises_cubit.dart';

class CustomSelectButtonBlocBuilder extends StatelessWidget {
  const CustomSelectButtonBlocBuilder({super.key, required this.exercises, required this.daySchedule, required this.selectedCount});

  final List<ExerciseModel> exercises;
  final DayScheduleModel daySchedule;
  final int selectedCount;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddExercisesCubit, AddExercisesState>(
      listener: (context, state) {
        if (state is AddExercisesSuccess) {
          context.read<GetAllDayExercisesCubit>().getAllDaysExercises();
          ToastHelper().showSuccessToast(
              context, "Exercises added successfully");
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
    );

  }
}

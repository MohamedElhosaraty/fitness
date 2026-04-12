
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/weekly_schedule_model.dart';
import '../../../domain/repos/workout_repo.dart';

part 'get_day_exercises_state.dart';

class GetDayExercisesCubit extends Cubit<GetDayExercisesState> {
  GetDayExercisesCubit( this.repo) : super(GetDayExercisesInitial());

  final WorkoutRepo repo;


  Future<void> getDayExercises({required String dayName}) async {
    emit(GetDayExercisesLoading());
    final result = await repo.getDayExercises(dayName: dayName);
    result.fold(
          (failure) => emit(GetDayExercisesError(failure.message)),
          (day) => emit(GetDayExercisesSuccess( day: day)),
    );
  }
}

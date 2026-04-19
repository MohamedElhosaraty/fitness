import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/day_schedule_model.dart';
import '../../../domain/repos/workout_repo.dart';

part 'get_all_day_exercises_state.dart';

class GetAllDayExercisesCubit extends Cubit<GetAllDayExercisesState> {
  GetAllDayExercisesCubit(this.repo) : super(GetAllDayExercisesInitial());

  final WorkoutRepo repo;

  Future<void> getAllDaysExercises() async {
    emit(GetAllDayExercisesLoading());

    final result = await repo.getAllDaysExercises();

    if (isClosed) return;
    result.fold(
          (failure) => emit(GetAllDayExercisesError(failure.message)),
          (listDays) => emit(GetAllDayExercisesSuccess(listDays: listDays)),
    );
  }

  Future<void> updateDayToRest(DayScheduleModel day) async {
    final result = await repo.addExercises(days: day.copyWith(exercises: []));

    if (isClosed) return;
    result.fold(
          (failure) => emit(GetAllDayExercisesError(failure.message)),
          (_) => getAllDaysExercises(),
    );
  }
}
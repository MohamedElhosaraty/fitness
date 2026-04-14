import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/day_schedule_model.dart';
import '../../../domain/repos/workout_repo.dart';

part 'get_day_exercises_state.dart';

class GetDayExercisesCubit extends Cubit<GetDayExercisesState> {
  GetDayExercisesCubit(this.repo) : super(GetDayExercisesInitial());

  final WorkoutRepo repo;
  StreamSubscription? _subscription;

  void watchDayExercises({required String dayName}) {
    emit(GetDayExercisesLoading());

    _subscription?.cancel();
    _subscription = repo.watchDayExercises(dayName: dayName).listen(
          (result) {
        if (isClosed) return;
        result.fold(
              (failure) => emit(GetDayExercisesError(failure.message)),
              (day) => emit(GetDayExercisesSuccess(day: day)),
        );
      },
      onError: (e) {
        if (isClosed) return;
        emit(GetDayExercisesError(e.toString()));
      },
    );
  }

  Future<void> updateDayToRest(DayScheduleModel day) async {
    final updatedDay = day.copyWith(exercises: []);

    final result = await repo.addExercises(days: updatedDay);

    if (isClosed) return;
    result.fold(
          (failure) => emit(GetDayExercisesError(failure.message)),
          (_) => watchDayExercises(dayName: day.dayName),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/weekly_schedule_model.dart';
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
          (result) => result.fold(
            (failure) => emit(GetDayExercisesError(failure.message)),
            (day) => emit(GetDayExercisesSuccess(day: day)),
      ),
      onError: (e) => emit(GetDayExercisesError(e.toString())),
    );
  }

  // ✅ بيكتب على Firebase exercises فاضية + بيحدّث الـ UI
  Future<void> updateDayToRest(DaySchedule day) async {
    _subscription?.cancel();

    final updatedDay = day.copyWith(exercises: []);

    final result = await repo.addExercises(days: updatedDay);

    result.fold(
          (failure) => emit(GetDayExercisesError(failure.message)),
          (_) => emit(GetDayExercisesSuccess(day: updatedDay)),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
class WorkoutSet {
  final double weight;
  final int reps;
  final bool isDone;
  final bool isActive;

  const WorkoutSet({
    required this.weight,
    required this.reps,
    this.isDone = false,
    this.isActive = false,
  });

  WorkoutSet copyWith({
    double? weight,
    int? reps,
    bool? isDone,
    bool? isActive,
  }) {
    return WorkoutSet(
      weight: weight ?? this.weight,
      reps: reps ?? this.reps,
      isDone: isDone ?? this.isDone,
      isActive: isActive ?? this.isActive,
    );
  }
}

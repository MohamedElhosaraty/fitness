class ExerciseModel {
  final String name;
  final String muscle;
  final bool isSelected;

  ExerciseModel({
    required this.name,
    required this.muscle,
    this.isSelected = false,
  });

  factory ExerciseModel.fromMap(Map<String, dynamic> map) {
    return ExerciseModel(
      name: map['name'] ?? '',
      muscle: map['muscle'] ?? '',
      isSelected: false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'muscle': muscle,
    };
  }
}
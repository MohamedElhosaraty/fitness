enum WorkoutCategory {
  push('💪 Push'),
  pull('🔙 Pull'),
  legs('🦵 Legs'),
  upper('💪 Upper Body'),
  lowerBody('🦵 Lower Body'),
  fullBody('🏋️ Full Body'),
  chest('💪 Chest'),
  back('🔙 Back'),
  shoulders('🤷 Shoulders'),
  arms('💪 Arms'),
  rest('😴 Rest');

  const WorkoutCategory(this.label);
  final String label;
}

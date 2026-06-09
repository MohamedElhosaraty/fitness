class SlotCalculatorUtility {
  static ({List<int?> slots, int? r1ToStore}) calculateActiveSlots(
      int total,
      int daysPlayed,
      int? lastSlot,
      int daysSinceSaturday,
      int? storedR1,
      ) {
    if (total <= 4) {
      return calculateActiveSlotsForTWoToFourDays(
        total,
        daysPlayed,
        lastSlot,
        daysSinceSaturday,
      );
    } else {
      return calculateActiveSlotsForMoreThanFourDays(
        total,
        daysPlayed,
        lastSlot,
        daysSinceSaturday,
        storedR1,
      );
    }
  }

  static ({List<int?> slots, int? r1ToStore})
  calculateActiveSlotsForMoreThanFourDays(
      int total,
      int daysPlayed,
      int? lastSlot,
      int daysSinceSaturday,
      int? storedR1,
      ) {
    if (daysPlayed == 0 && lastSlot == null) {
      return (
      slots: _getInitialSlotsForMorThanFourDays(daysSinceSaturday, total),
      r1ToStore: null,
      );
    }

    return _getFollowUpSlotsForMoreThanFourDays(
      total,
      daysPlayed,
      lastSlot!,
      daysSinceSaturday,
      storedR1,
    );
  }

  static ({List<int?> slots, int? r1ToStore})
  calculateActiveSlotsForTWoToFourDays(
      int total,
      int daysPlayed,
      int? lastSlot,
      int daysSinceSaturday,
      ) {
    if (daysSinceSaturday == 0) {
      return (slots: _getSaturdaySlots(total), r1ToStore: null);
    }

    if (daysPlayed == 0 && lastSlot == null) {
      return (
      slots: _getInitialSlots(daysSinceSaturday, total),
      r1ToStore: null,
      );
    }

    return (
    slots: _getFollowUpSlots(total, daysPlayed, lastSlot!, daysSinceSaturday),
    r1ToStore: null,
    );
  }

  static List<int?> _getSaturdaySlots(int total) {
    List<int> activeSlots = [];
    for (int i = 0; i <= 6; i = i + 2) {
      activeSlots.add(i);
    }
    return activeSlots.take(total).toList();
  }

  static List<int?> _getInitialSlots(int daysSinceSaturday, int total) {
    List<int?> slots = [];
    final currentSlot = daysSinceSaturday + 1;
    for (int i = currentSlot - 1; i <= 6; i = i + 2) {
      slots.add(i);
    }
    return slots.take(total).toList();
  }

  static List<int?> _getInitialSlotsForMorThanFourDays(
      int daysSinceSaturday,
      int total,
      ) {
    List<int?> slots = [];
    final currentSlot = daysSinceSaturday + 1;
    final currentSlotIndex = currentSlot - 1;
    final int r1;
    if (total == 5) {
      r1 = currentSlotIndex + 2;
    } else {
      r1 = currentSlotIndex + 3;
    }
    final r2 = r1 + 1 + 3;

    for (int i = currentSlotIndex; i <= 6; i++) {
      if (i != r1 && i != r2) {
        slots.add(i);
      }
    }
    return slots.take(total).toList();
  }

  static List<int?> _getFollowUpSlots(
      int total,
      int daysPlayed,
      int lastSlot,
      int daysSinceSaturday,
      ) {
    final isOddPattern = lastSlot.isOdd;
    final allSlots = <int?>[];

    if (isOddPattern) {
      for (int i = 1; i <= 6; i = i + 2) {
        allSlots.add(i);
      }
    } else {
      for (int i = 0; i <= 6; i = i + 2) {
        allSlots.add(i);
      }
    }

    final remaining = allSlots.where((s) => s! > lastSlot).toList();

    if (remaining.isNotEmpty && remaining.first! < daysSinceSaturday) {
      remaining[0] = daysSinceSaturday;

      for (int i = 1; i < remaining.length; i++) {
        remaining[i] = remaining[i - 1]! + 2;
      }
    }

    final daysLeft = total - daysPlayed;
    return remaining.take(daysLeft).toList();
  }

  static ({List<int?> slots, int? r1ToStore})
  _getFollowUpSlotsForMoreThanFourDays(
      int total,
      int daysPlayed,
      int lastSlot,
      int daysSinceSaturday,
      int? storedR1,
      ) {
    final currentSlotIndex = daysSinceSaturday;
    if (lastSlot == currentSlotIndex) {
      daysPlayed = daysPlayed - 1;
    }

    final int r1;
    int? r1ToStore;

    if (storedR1 != null) {
      r1 = storedR1;
    } else if (total == 5) {
      r1 = currentSlotIndex + (2 - daysPlayed);
      if (daysPlayed == 2) r1ToStore = r1;
    } else {
      r1 = currentSlotIndex + (3 - daysPlayed);
      if (daysPlayed == 3) r1ToStore = r1;
    }

    final r2 = r1 + 4;
    final slots = <int?>[];
    for (int i = currentSlotIndex; i <= 6; i++) {
      if (i != r1 && i != r2) slots.add(i);
    }

    if (lastSlot == currentSlotIndex) {
      slots.remove(currentSlotIndex);
    }

    return (slots: slots.take(total).toList(), r1ToStore: r1ToStore);
  }
}
import 'package:fitness/core/utils/home_day_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

    group('_calculateActiveSlots - total = 3', () {

      test('daysPlayed=0, lastSlot=null, daysSinceSaturday=0', () {
        final result = HomeDayUtils.calculateActiveSlots(
           3,
           0,
           null,
           0,
        );
        expect(result, equals([0, 2, 4]));
      });

      test(' daysPlayed=1, lastSlot=1, daysSinceSaturday=0', () {
        final result = HomeDayUtils.calculateActiveSlots(
          3,
          1,
          1,
          0,
        );
        expect(result, equals([0, 2, 4]));
      });

      test(' daysPlayed=1, lastSlot=1, daysSinceSaturday=1', () {
        final result = HomeDayUtils.calculateActiveSlots(
           3,
            1,
             1,
             1,
        );
        expect(result, equals([2, 4]));
      });

      test(' daysPlayed=1, lastSlot=1, daysSinceSaturday=2', () {
        final result = HomeDayUtils.calculateActiveSlots(
          3,
           1,
           1,
           2,
        );
        expect(result, equals([2, 4]));
      });

    });
}
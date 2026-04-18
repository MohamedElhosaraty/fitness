import 'package:fitness/feature/home/ui/widgets/custom_split_button.dart';
import 'package:fitness/feature/home/domain/entity/training_split_type.dart';

class SplitCardData {
  final TrainingSplitType type;
  final String title;
  final String subtitle;
  final List<CustomSplitButton> buttons;

  const SplitCardData({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.buttons,
  });
}
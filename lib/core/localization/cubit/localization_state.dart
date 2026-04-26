part of 'localization_cubit.dart';

sealed class LocalizationState {}

final class LocalizationInitial extends LocalizationState {}

final class ChangeLanguageSuccess extends LocalizationState {
  final Locale language;

  ChangeLanguageSuccess({required this.language});
}
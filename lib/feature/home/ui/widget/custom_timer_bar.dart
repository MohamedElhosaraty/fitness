import 'dart:async';

import 'package:fitness/core/localization/localization_methods.dart';
import 'package:fitness/feature/home/ui/widget/custom_progress_bar.dart';
import 'package:fitness/feature/home/ui/widget/custom_timer_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/rest_timer_notification_service.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/app_strings.dart';

class CustomTimerBar extends StatefulWidget {
  const CustomTimerBar({super.key, required this.timerSeconds});

  final int timerSeconds;

  @override
  State<CustomTimerBar> createState() => _CustomTimerBarState();
}

class _CustomTimerBarState extends State<CustomTimerBar> {
  Timer? _timer;
  bool _isTimerRunning = false;
  late int _remainingSeconds;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.timerSeconds;
  }

  @override
  void didUpdateWidget(CustomTimerBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.timerSeconds != widget.timerSeconds) {
      _resetTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _toggleTimer() {
    _isTimerRunning ? _resetTimer() : _startTimer();
  }

  Future<void> _startTimer() async {
    if (!mounted) return;
    final String title = tr(context, AppStrings.finishRestTime);
    final String body = tr(context, AppStrings.breakTimeOverStartNextSet);
    await AlarmScheduler.cancelAllAlarms();
    await AlarmScheduler.scheduleAlarm(
      duration: Duration(seconds: _remainingSeconds),
      title: title,
      body: body,
    );
    if (!mounted) return;
    setState(() => _isTimerRunning = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      setState(() => _remainingSeconds--);

      if (_remainingSeconds <= 0) {
        timer.cancel();
        _resetTimer(cancelAlarm: false);
      }
    });
  }

  void _resetTimer({bool cancelAlarm = true}) {
    _timer?.cancel();
    if (cancelAlarm) AlarmScheduler.cancelAllAlarms();
    if (!mounted) return;
    setState(() {
      _isTimerRunning = false;
      _remainingSeconds = widget.timerSeconds;
    });
  }

  Color get _timerColor =>
      _isTimerRunning ? AppColors.greenSecondary : AppColors.primaryColor;

  String get _timerLabel {
    if (_isTimerRunning) {
      final m = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
      final s = (_remainingSeconds % 60).toString().padLeft(2, '0');
      return '${tr(context, AppStrings.rest)} — $m:$s';
    }

    final tm = (widget.timerSeconds ~/ 60).toString().padLeft(2, '0');
    final ts = (widget.timerSeconds % 60).toString().padLeft(2, '0');
    return '${tr(context, AppStrings.startRestTimer)} ($tm:$ts)';
  }

  double get _timerProgress =>
      (widget.timerSeconds - _remainingSeconds) / widget.timerSeconds;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomProgressBar(
            timerProgress: _timerProgress,
            timerColor: _timerColor,
          ),
          10.verticalSpace,
          CustomTimerButton(
            isTimerRunning: _isTimerRunning,
            timerLabel: _timerLabel,
            timerColor: _timerColor,
            toggleTimer: _toggleTimer,
          ),
        ],
      ),
    );
  }
}

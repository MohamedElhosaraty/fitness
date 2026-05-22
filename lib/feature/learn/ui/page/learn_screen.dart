import 'package:flutter/material.dart';

import '../widget/learn_screen_body.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: const LearnScreenBody(),
    );
  }
}

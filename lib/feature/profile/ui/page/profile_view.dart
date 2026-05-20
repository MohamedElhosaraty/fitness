import 'package:flutter/material.dart';

import '../widget/profile_screen_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: const ProfileScreenBody(),
    );
  }
}

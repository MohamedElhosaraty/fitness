import 'package:fitness/core/theming/app_colors.dart';
import 'package:fitness/feature/home/ui/page/home_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/bottom_nav_bar.dart';
import '../../learn/ui/page/learn_screen.dart';
import '../../profile/ui/page/profile_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    LearnScreen(),
    ProfileView(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: _pages[_selectedIndex],
      bottomNavigationBar: MyBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onTabTapped,
      ),
    );
  }
}

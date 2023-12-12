import 'package:flutter/material.dart';
import 'package:restaurant_favourite_app/src/screens/info.dart';
import 'package:restaurant_favourite_app/src/screens/restaurant_list.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late PageController _pageController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }

  void onButtonPressed(int index) {
    setState(() {
      selectedIndex = index;
    });
    _pageController.animateToPage(selectedIndex,
        duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: _pages,
      ),
      bottomNavigationBar: SlidingClippedNavBar(
        backgroundColor: Colors.deepPurple,
        onButtonPressed: onButtonPressed,
        iconSize: 25,
        activeColor: Colors.white,
        selectedIndex: selectedIndex,
        barItems: <BarItem>[
          BarItem(
            icon: Icons.restaurant_rounded,
            title: 'Restaurant',
          ),
          BarItem(
            icon: Icons.favorite,
            title: 'Favorite',
          ),
          BarItem(
            icon: Icons.info,
            title: 'Info',
          ),
        ],
      ),
    );
  }
}

List<Widget> _pages = <Widget>[
  // const AdminDashboard(),
  const RestaurantListScreen(),
  const Text('Restaurant Fav Screen'),
  const InfoScreen(),
];

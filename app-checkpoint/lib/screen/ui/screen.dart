import 'package:checkpoint/screen/ui/widgets/bottom_navigation.dart';
import 'package:checkpoint/widgets/cards/attendence.dart';
import 'package:checkpoint/views/nav_pages/homepage.dart';
import 'package:checkpoint/views/nav_pages/profile.dart';
import 'package:checkpoint/views/nav_pages/my_leaves.dart';
import 'package:flutter/material.dart';

class Screen extends StatefulWidget {
  final int initialPage;

  const Screen({
    super.key,
    this.initialPage = 0, // Default to the first page if no page is specified
  });

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  late PageController pageController;
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.initialPage); // Set the initial page
    _currentPageNotifier.value = widget.initialPage; // Set the initial value for the notifier
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          _currentPageNotifier.value = index;
        },
        children: const [HomePage(), Attendence(), MyLeaves(), Profile()],
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _currentPageNotifier,
        builder: (context, currentIndex, child) {
          return Menu(
            screenWidth: screenWidth,
            currentIndex: currentIndex,
            onIconPressed: (index) {
              pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
              _currentPageNotifier.value = index;
            },
          );
        },
      ),
    );
  }
}

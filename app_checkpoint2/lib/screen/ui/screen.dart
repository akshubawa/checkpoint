import 'package:app_checkpoint2/screen/ui/widgets/bottom_navigation.dart';
import 'package:app_checkpoint2/views/attendence.dart';
import 'package:app_checkpoint2/views/home/ui/homepage.dart';
import 'package:app_checkpoint2/views/more.dart';
import 'package:app_checkpoint2/views/myteam.dart';
import 'package:flutter/material.dart';

class Screen extends StatefulWidget {
  const Screen({
    super.key,
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
    pageController = PageController();
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
        children: [HomePage(), Attendence(), Myteam(), Profile()],
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

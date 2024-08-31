import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uicons_pro/uicons_pro.dart';

class Menu extends StatefulWidget {
  final double screenWidth;
  final int currentIndex;
  final Function(int) onIconPressed;

  const Menu({
    super.key,
    required this.screenWidth,
    required this.currentIndex,
    required this.onIconPressed,
  });

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  Map<IconData, String> listOfIcons = {
    UIconsPro.regularRounded.home: "Home",
    UIconsPro.regularRounded.clipboard_list_check: "Attendence",
    UIconsPro.regularRounded.users: "My Leaves",
    UIconsPro.regularRounded.user: "Profile",
  };
  Map<IconData, String> listOfIcons2 = {
    UIconsPro.solidRounded.home: "Home",
    UIconsPro.solidRounded.clipboard_list_check: "Attendence",
    UIconsPro.solidRounded.users: "My Leaves",
    UIconsPro.solidRounded.user: "Profile",
  };

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GlassContainer(
      width: widget.screenWidth,
      height: 66,
      blur: 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: listOfIcons.keys.map((iconData) {
          int index = listOfIcons.keys.toList().indexOf(iconData);
          return InkWell(
            onTap: () {
              widget.onIconPressed(index);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  index == widget.currentIndex
                      ? listOfIcons2.keys.elementAt(index)
                      : iconData,
                  fill: 1,
                  size: size.width * .065,
                  color: index == widget.currentIndex
                      ? Colors.blueAccent
                      : Colors.grey,
                ),
                Text(
                  listOfIcons.values.elementAt(index),
                  style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w500,
                      color: index == widget.currentIndex
                          ? Colors.blueAccent
                          : Colors.grey),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

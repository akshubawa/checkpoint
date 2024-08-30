import 'package:flutter/material.dart';

class SideMenuTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const SideMenuTile(
      {required this.title,
      required this.icon,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    // Color textColor =
    //     Theme.of(context).colorScheme.onSurface.withOpacity(0.5);
    Color textColor =
        Colors.black.withOpacity(0.7);
    return Column(
      children: [
        const Divider(
          color: Colors.grey,
          height: 1,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary.withOpacity(0.001),
          ),
          child: ListTile(
            onTap: onTap,
            leading: SizedBox(
              child: FractionallySizedBox(
                heightFactor: 0.8,
                child: Icon(
                  icon,
                  color:
                    textColor,
                )
                  ),
                ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: textColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

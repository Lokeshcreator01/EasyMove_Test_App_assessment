import 'package:easymove/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({
    required this.selectedIndex,
    required this.onItemSelected,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    const items = [
      {'icon': Icons.home_outlined, 'label': 'Home'},
      {'icon': Icons.apps_outlined, 'label': 'Services'},
      {'icon': Icons.chat_bubble_outline, 'label': 'Chat'},
      {'icon': Icons.favorite_border, 'label': 'Saved'},
      {'icon': Icons.person_outline, 'label': 'Profile'},
    ];

    return Container(
      padding: EdgeInsets.only(top: 7, bottom: bottomInset + 5),
      decoration: const BoxDecoration(
        color: HomeColors.bottomBar,
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (var index = 0; index < items.length; index++)
            GestureDetector(
              onTap: () => onItemSelected(index),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    items[index]['icon'] as IconData,
                    size: 23,
                    color: index == selectedIndex
                        ? HomeColors.dark
                        : HomeColors.muted,
                  ),
                  Text(
                    items[index]['label'] as String,
                    style: TextStyle(
                      fontSize: 10,
                      color: index == selectedIndex
                          ? HomeColors.dark
                          : HomeColors.muted,
                      fontWeight: index == selectedIndex
                          ? FontWeight.w700
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

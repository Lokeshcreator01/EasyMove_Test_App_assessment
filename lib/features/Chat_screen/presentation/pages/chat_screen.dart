import 'package:easymove/core/constants/app_colors.dart';
import 'package:easymove/core/constants/app_strings.dart';
import 'package:easymove/core/constants/app_styles.dart';
import 'package:easymove/core/constants/img_constants.dart';
import 'package:easymove/core/widgets/app_bottom_navigation.dart';
import 'package:easymove/features/Chat_screen/presentation/widgets/widgets.dart';
import 'package:easymove/features/homescreen/presentation/pages/side_bar_screen.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(97),
        child: Container(
          margin: EdgeInsets.zero,
          decoration: const BoxDecoration(
            color: HomeColors.bottomBar,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(28),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: Image.asset(
                      ImgConstants.logo,
                      height: 38,
                      fit: BoxFit.contain,
                      errorBuilder: (_, _, _) => const SizedBox(height: 38),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    flex: 3,
                    child: Container(
                      height: 32,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.72),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              HomeStrings.location,
                              overflow: TextOverflow.ellipsis,
                              style: WidgetStyle.country,
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_down, size: 18),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.notifications_none, size: 22),
                  const SizedBox(width: 5),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 24,
                      minHeight: 24,
                    ),
                    icon: const Icon(Icons.menu, size: 26),
                    onPressed: () =>
                        scaffoldKey.currentState?.openEndDrawer(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      endDrawer: const SideBarScreen(),
      body: const chatview(),
      bottomNavigationBar: const AppBottomNavigation(selectedIndex: 2),

    );
  }
}
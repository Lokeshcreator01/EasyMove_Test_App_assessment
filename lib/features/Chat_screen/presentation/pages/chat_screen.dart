import 'package:easymove/core/constants/app_colors.dart';
import 'package:easymove/core/constants/app_strings.dart';
import 'package:easymove/core/constants/app_styles.dart';
import 'package:easymove/core/constants/img_constants.dart';
import 'package:easymove/core/widgets/app_bottom_navigation.dart';
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
      body: const _chatview(),
      bottomNavigationBar: const AppBottomNavigation(selectedIndex: 2),

    );
  }
}

class User{
  final String name;
  final String chat;
  final String ima_url;

  const User({
    required this.name,
    required this.chat,
    required this.ima_url,
});
}

class _chatview extends StatefulWidget {
  const _chatview();

  @override
  State<_chatview> createState() => _chatviewState();
}

class _chatviewState extends State<_chatview> {
  List<User> user =[
    const User(name: 'Darlene Steward', chat: 'Hi, how are you?', ima_url: "https://images.unsplash.com/photo-1633332755192-727a05c4013d"),
    const User(name: 'Darlene Steward', chat: 'Hi, how are you?', ima_url: "https://images.unsplash.com/photo-1633332755192-727a05c4013d"),
    const User(name: 'Darlene Steward', chat: 'Hello how can i help you', ima_url: "https://images.unsplash.com/photo-1633332755192-727a05c4013d"),
    const User(name: 'Darlene Steward', chat: 'Thank you for your offer', ima_url: "https://images.unsplash.com/photo-1633332755192-727a05c4013d"),
    const User(name: 'Darlene Steward', chat: 'Hi, how are you?', ima_url: "https://images.unsplash.com/photo-1633332755192-727a05c4013d"),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: user.length,itemBuilder: (context, index){
      final user1 =user[index];
      return Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(user1.ima_url),
          ),
          title: Text(user1.name),
          subtitle: Text(user1.chat),
        ),
      );
    }
    );
  }
}
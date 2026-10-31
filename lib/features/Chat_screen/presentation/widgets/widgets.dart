import 'package:flutter/material.dart';

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

class chatview extends StatefulWidget {
  const chatview();

  @override
  State<chatview> createState() => _chatviewState();
}

class _chatviewState extends State<chatview> {
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
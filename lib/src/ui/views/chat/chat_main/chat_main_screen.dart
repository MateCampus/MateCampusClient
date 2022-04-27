import 'package:flutter/material.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/views/chat/chat_main/components/body.dart';

class ChatMainScreen extends StatelessWidget {
  const ChatMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('채팅',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.maps_ugc_outlined),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
            color: Colors.black,
          ),
        ],
        elevation: 0.0,
        backgroundColor: const Color(0xfff8f8f8),
      ),
      backgroundColor: const Color(0xfff8f8f8),
      body: Body(),
    );
  }
}

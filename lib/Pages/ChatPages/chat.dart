import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sheetsense/Pages/ChatPages/mobile_chatpage.dart';
import 'package:sheetsense/Pages/ChatPages/web_chatpage.dart';
import 'package:sheetsense/Provider/chat_provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void didChangeDependencies() async {
    Provider.of<ChatProvider>(context).updateChatStream();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      desktop: (context) {
        return const WebChatPage();
      },
      mobile: (context) {
        return const MobileChatPage();
      },
    );
  }
}

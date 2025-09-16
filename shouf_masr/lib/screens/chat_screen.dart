import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat'), backgroundColor: const Color(0xFFcdcc00)),
      body: Column(
        children: [
          const Expanded(child: Center(child: Text('Chat conversation goes here'))),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Expanded(child: TextField(decoration: const InputDecoration(hintText: 'Type a message'))),
              IconButton(onPressed: (){}, icon: const Icon(Icons.send, color: Color(0xFFcdcc00))),
            ]),
          )
        ],
      ),
    );
  }
}

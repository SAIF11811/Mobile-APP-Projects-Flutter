import 'package:flutter/material.dart';

import '../widgets/bottom_nav.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFcdcc00),
        title: const Text("Messages"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          MessageTile(
            sender: "Alice",
            message: "Hey, are you ready for the trip?",
            time: "2m ago",
          ),
          MessageTile(
            sender: "John",
            message: "Don’t forget our meeting tomorrow.",
            time: "10m ago",
          ),
          MessageTile(
            sender: "Travel Support",
            message: "Your booking has been confirmed!",
            time: "1h ago",
          ),
        ],
      ),

      bottomNavigationBar: const BottomNav(currentIndex: 3),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String sender;
  final String message;
  final String time;

  const MessageTile({
    super.key,
    required this.sender,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(
          sender,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(message, maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: Text(
          time,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        onTap: () {
          // TODO: Navigate to chat detail
        },
      ),
    );
  }
}

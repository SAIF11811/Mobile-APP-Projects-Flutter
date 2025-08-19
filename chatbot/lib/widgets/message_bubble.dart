import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  const MessageBubble({
    super.key,
    required this.text,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 400),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(isUser ? 20 * (1 - value) : -20 * (1 - value), 0),
            child: child,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        child: Row(
          mainAxisAlignment:
          isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isUser) _buildAvatar(false),
            const SizedBox(width: 8),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(14),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                decoration: BoxDecoration(
                  gradient: isUser
                      ? const LinearGradient(
                    colors: [Colors.indigoAccent, Colors.blueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                      : const LinearGradient(
                    colors: [Color(0xFF2A2A2A), Color(0xFF1A1A1A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(16),
                    topRight: const Radius.circular(16),
                    bottomLeft:
                    isUser ? const Radius.circular(16) : Radius.zero,
                    bottomRight:
                    isUser ? Radius.zero : const Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                child: SelectableText(
                  text,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.4,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            if (isUser) _buildAvatar(true),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(bool user) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: user ? Colors.indigoAccent.withOpacity(0.6) : Colors.deepPurple.withOpacity(0.6),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 18,
        backgroundColor: user ? Colors.indigo : Colors.deepPurple,
        child: Icon(
          user ? Icons.person : Icons.smart_toy,
          color: Colors.white,
        ),
      ),
    );
  }
}

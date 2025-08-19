import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/chat_service.dart';
import '../widgets/message_bubble.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final ScrollController _scrollController = ScrollController();
  final ChatService _chatService = ChatService();
  bool _isTyping = false;

  late AnimationController _sendBtnController;

  @override
  void initState() {
    super.initState();
    _sendBtnController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _sendBtnController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    _sendBtnController.forward().then((_) => _sendBtnController.reverse());

    setState(() {
      _messages.add({"role": "user", "text": text});
      _isTyping = true;
      _controller.clear();
    });
    _scrollToBottom();

    final reply = await _chatService.sendMessage(text);

    setState(() {
      _messages.add({"role": "bot", "text": reply});
      _isTyping = false;
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  Widget _typingIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundColor: Colors.deepPurple,
            child: Icon(Icons.smart_toy, color: Colors.white),
          ),
          const SizedBox(width: 12),
          SizedBox(
            height: 20,
            child: Row(
              children: List.generate(3, (i) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300 + (i * 200)),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Talkio",
          style: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.grey[900],
        elevation: 6,
        shadowColor: Colors.black54,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_note_outlined, color: Colors.white, size: 30,),
            tooltip: "New Chat",
            onPressed: () {
              setState(() {
                _messages.clear();
                _isTyping = false;
              });
              _scrollToBottom();
            },
          ),
        ],
      ),


      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2E2E2E), Color(0xFF121212)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                itemCount: _messages.length + (_isTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (_isTyping && index == _messages.length) {
                    return _typingIndicator();
                  }
                  final msg = _messages[index];
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, anim) => FadeTransition(
                      opacity: anim,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.1, 0.1),
                          end: Offset.zero,
                        ).animate(anim),
                        child: child,
                      ),
                    ),
                    child: MessageBubble(
                      key: ValueKey(msg),
                      text: msg["text"]!,
                      isUser: msg["role"] == "user",
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(12, 6, 12, 18),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        hintText: "Type your message...",
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        filled: true,
                        fillColor: Colors.grey[900],
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ScaleTransition(
                    scale: Tween(begin: 1.0, end: 1.3)
                        .animate(CurvedAnimation(
                      parent: _sendBtnController,
                      curve: Curves.easeOutBack,
                    )),
                    child: FloatingActionButton(
                      mini: true,
                      onPressed: _sendMessage,
                      backgroundColor: Colors.indigo,
                      child: const Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

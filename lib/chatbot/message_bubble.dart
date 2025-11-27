import 'package:flutter/material.dart';
import 'message_model.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel msg;
  const MessageBubble({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    final isUser = msg.sender == 'user';
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser ? Colors.indigoAccent : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              msg.text,
              style: TextStyle(color: isUser ? Colors.white : Colors.black87),
            ),
            if (msg.emotion != null)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  'emotion: ${msg.emotion}',
                  style: TextStyle(
                    fontSize: 11,
                    color: isUser ? Colors.white70 : Colors.black54,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

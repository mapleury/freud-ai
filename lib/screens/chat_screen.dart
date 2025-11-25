import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import '../services/hf_service.dart';
import '../models/message_model.dart';
import '../widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _ctrl = TextEditingController();
  final ScrollController _scroll = ScrollController();
  late FirebaseService _fb;
  late HuggingFaceService _hf;
  bool _isSending = false;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _fb = FirebaseService();
    _hf = HuggingFaceService();
    _fb.ensureSignedInAnonymously();
  }

  Future<void> _send() async {
    final text = _ctrl.text.trim();
    if (text.isEmpty || _isSending) return;
    setState(() {
      _isSending = true;
      _isTyping = true;
    });
    _ctrl.clear();

    final userMsg = MessageModel(
      id: '',
      text: text,
      sender: 'user',
      timestamp: DateTime.now(),
    );
    await _fb.addMessage(userMsg);

    String? detectedEmotion;
    try {
      detectedEmotion = await _hf.detectEmotion(text);
    } catch (_) {
      detectedEmotion = null;
    }

    if (detectedEmotion != null) {
      final userMsgWithEmotion = MessageModel(
        id: '',
        text: text,
        sender: 'user',
        timestamp: DateTime.now(),
        emotion: detectedEmotion,
      );
      await _fb.addMessage(userMsgWithEmotion);
    }

    final prompt = StringBuffer();
    prompt.writeln('User: $text');
    if (detectedEmotion != null) {
      prompt.writeln('UserEmotion: $detectedEmotion');
    }
    prompt.writeln('Assistant:');

    String assistantText;
    try {
      assistantText = await _hf.generateResponse(prompt.toString());
    } catch (e) {
      assistantText = "I couldn't reach the language model right now. Try again later.";
    }

    final assistantMsg = MessageModel(
      id: '',
      text: assistantText,
      sender: 'assistant',
      timestamp: DateTime.now(),
    );
    await _fb.addMessage(assistantMsg);

    await Future.delayed(const Duration(milliseconds: 200));
    _scrollToBottom();

    setState(() {
      _isSending = false;
      _isTyping = false;
    });
  }

  void _scrollToBottom() {
    if (_scroll.hasClients) {
      _scroll.animateTo(
        _scroll.position.maxScrollExtent + 100,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Widget _buildInput() {
    return SafeArea(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: TextField(
                controller: _ctrl,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _send(),
                decoration: InputDecoration(
                  hintText: 'Ask Freud anything (or misremembered trivia).',
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: _isSending
                ? const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)),
                  )
                : IconButton(
                    onPressed: _send,
                    icon: const Icon(Icons.send_rounded),
                    color: Colors.indigo,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(12)),
            child: const Text('Freud is typing...'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Freud Chat'),
        actions: [
          IconButton(
            tooltip: 'Clear chat (dev)',
            onPressed: () async {
              await _fb.clearChat();
            },
            icon: const Icon(Icons.delete_forever),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<MessageModel>>(
              stream: _fb.streamMessages(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final msgs = snap.data ?? [];
                return ListView.builder(
                  controller: _scroll,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: msgs.length + (_isTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (_isTyping && index == msgs.length) {
                      return _buildTypingIndicator();
                    }
                    final msg = msgs[index];
                    return MessageBubble(msg: msg);
                  },
                );
              },
            ),
          ),
          _buildInput(),
        ],
      ),
    );
  }
}

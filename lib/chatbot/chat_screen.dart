import 'package:final_project/chatbot/my_chats_screen.dart';
import 'package:flutter/material.dart';
import 'message_model.dart';
import 'message_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _ctrl = TextEditingController();
  final ScrollController _scroll = ScrollController();

  bool _isSending = false;
  bool _isTyping = false;

  final List<MessageModel> _messages = [
    MessageModel(
      id: '1',
      text:
          "Hi! I'm Fred. I’m here to listen. Share anything that’s on your mind. How are you feeling today?",
      sender: 'assistant',
      timestamp: DateTime.now(),
    ),
  ];

  Future<String> _getReply(String userText) async {
    final text = userText.toLowerCase();

    if (text.contains("not feeling well") ||
        text.contains("feeling sick") ||
        text.contains("bad day") ||
        text.contains("ga enak")) {
      return "Sounds heavy. It's okay if you're not doing well today. You're trying your best just by being here.";
    }

    if (text.contains("sad") ||
        text.contains("sedih") ||
        text.contains("down")) {
      return "Feeling sad doesn't make you weak. It means you're alive and feeling. I'm right here.";
    }

    if (text.contains("anxiety") ||
        text.contains("anxious") ||
        text.contains("cemas") ||
        text.contains("khawatir")) {
      return "Anxiety eats energy fast. Try a slow breath… in, hold, and out. You're safe at this moment.";
    }

    if (text.contains("stress") ||
        text.contains("overwhelmed") ||
        text.contains("stres") ||
        text.contains("capek banget")) {
      return "When life gets too loud, it's okay to pause. You don't have to be strong every hour of every day.";
    }

    if (text.contains("broken") ||
        text.contains("heartbreak") ||
        text.contains("patah hati") ||
        text.contains("kecewa")) {
      return "Heartbreak hits deeper than we expect. You still deserve softness and care.";
    }

    if (text.contains("lonely") ||
        text.contains("alone") ||
        text.contains("kesepian")) {
      return "Loneliness hurts more than people admit. But you're not alone right now. I'm here.";
    }

    if (text.contains("no motivation") ||
        text.contains("unmotivated") ||
        text.contains("malas") ||
        text.contains("mager")) {
      return "Being unmotivated means your mind is tired, not that you're failing. Rest is allowed.";
    }

    if (text.contains("cry") ||
        text.contains("crying") ||
        text.contains("nangis")) {
      return "Crying doesn't make you weak. It's your heart trying to breathe again.";
    }

    if (text.contains("pressure") ||
        text.contains("tertekan") ||
        text.contains("beban")) {
      return "You've been carrying so much. You don't have to hold everything alone.";
    }

    if (text.contains("burnout") ||
        text.contains("burn out") ||
        text.contains("jenuh")) {
      return "Burnout means you've been strong for too long. It's okay to rest now.";
    }

    if (text.contains("lost") ||
        text.contains("confused") ||
        text.contains("bingung") ||
        text.contains("hilang arah")) {
      return "Feeling lost is part of becoming someone new. You're not failing, you're changing.";
    }

    if (text.contains("worthless") ||
        text.contains("not worth") ||
        text.contains("tidak berharga") ||
        text.contains("ga berguna")) {
      return "You matter, even when you can't feel it. Your presence already has weight.";
    }

    if (text.contains("hopeless") ||
        text.contains("putus asa") ||
        text.contains("ga ada harapan")) {
      return "Hope comes and goes. The fact you're still here means you're stronger than despair.";
    }

    if (text.contains("overthink") ||
        text.contains("overthinking") ||
        text.contains("kepikiran")) {
      return "Your mind is spinning fast. Try grounding: name 5 things you see, 4 things you can touch.";
    }

    if (text.contains("scared") ||
        text.contains("afraid") ||
        text.contains("takut")) {
      return "Fear doesn't make you weak. You're allowed to feel it, and you're safe here.";
    }

    if (text.contains("insecure")) {
      return "Your brain lies sometimes. You're worth more than the thoughts dragging you down.";
    }

    if (text.contains("tired of life") ||
        text.contains("emotionally tired") ||
        text.contains("capek hidup")) {
      return "You've carried so much for so long. It's okay to rest. You're still here and that matters.";
    }

    if (text.contains("regret") ||
        text.contains("menyesal") ||
        text.contains("nyesel")) {
      return "Regret means you care. You can still grow from here.";
    }

    if (text.contains("angry") ||
        text.contains("marah") ||
        text.contains("kesal")) {
      return "Anger often hides hurt. You can talk about it if you feel like it.";
    }

    if (text.contains("friend") ||
        text.contains("friends") ||
        text.contains("teman")) {
      return "Friend problems cut unexpectedly deep. Your feelings are valid.";
    }

    if (text.contains("school") ||
        text.contains("sekolah") ||
        text.contains("homework")) {
      return "School drains energy fast. You're doing more than you give yourself credit for.";
    }

    if (text.contains("home") ||
        text.contains("rumah") ||
        text.contains("family problems")) {
      return "Home isn't always peaceful. What you feel is real, and you deserve to be heard.";
    }

    if (text.contains("parent") ||
        text.contains("parents") ||
        text.contains("orang tua")) {
      return "Parents can be complicated. Your emotions still matter.";
    }

    return "That doesn’t seem related to mental health. Try telling me how you feel.";
  }

  Future<void> _send() async {
    final text = _ctrl.text.trim();
    if (text.isEmpty || _isSending) return;

    setState(() => _isSending = true);
    _ctrl.clear();

    final userMsg = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      sender: 'user',
      timestamp: DateTime.now(),
    );
    _messages.add(userMsg);
    setState(() {});
    _scrollToBottom();

    setState(() => _isTyping = true);

    await Future.delayed( Duration(seconds: 1));

    final reply = await _getReply(text);

    final botMsg = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: reply,
      sender: 'assistant',
      timestamp: DateTime.now(),
    );

    _messages.add(botMsg);

    setState(() {
      _isTyping = false;
      _isSending = false;
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration:  Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _buildHeader() {
    return Container(
      padding:  EdgeInsets.fromLTRB(16, 14, 16, 20),
      decoration:  BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  MyChatsScreen(),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/brown-back-button.png',
                  width: 40,
                  height: 40,
                ),
              ),
            ),
          ),
           SizedBox(width: 12),
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.brown.shade200,
              shape: BoxShape.circle,
            ),
            child:  Icon(Icons.person, color: Colors.white),
          ),
           SizedBox(width: 12),
           Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Doctor Freud.AI",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "251 Chats Left  •  GPT-6",
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTyping() {
    if (!_isTyping) return SizedBox.shrink();

    return Padding(
      padding:  EdgeInsets.only(left: 20, bottom: 10, top: 4),
      child: Container(
        padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.orange.shade300,
          borderRadius: BorderRadius.circular(20),
        ),
        child:  Text(
          "Typing...",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding:  EdgeInsets.fromLTRB(16, 8, 16, 20),
      decoration:  BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(30),
              ),
              padding:  EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _ctrl,
                decoration:  InputDecoration(
                  border: InputBorder.none,
                  hintText: "Type to start chatting...",
                ),
              ),
            ),
          ),
           SizedBox(width: 10),
          GestureDetector(
            onTap: _send,
            child: Container(
              padding:  EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Color(0xFF9BB167),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.send,
                color: _isSending ? Colors.white54 : Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFFEDE7DE),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            Expanded(
              child: ListView.builder(
                controller: _scroll,
                padding:  EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return MessageBubble(msg: _messages[index]);
                },
              ),
            ),

            _buildTyping(),
            _buildInputBar(),
          ],
        ),
      ),
    );
  }
}

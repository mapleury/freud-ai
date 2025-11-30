import 'package:final_project/chatbot/widgets/chat_card.dart';
import 'package:final_project/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'chat_screen.dart';

class MyChatsScreen extends StatefulWidget {
  const MyChatsScreen({super.key});

  @override
  State<MyChatsScreen> createState() => _MyChatsScreenState();
}

class _MyChatsScreenState extends State<MyChatsScreen> {
  int activeSegment = 0;

  final List<Map<String, dynamic>> recentChats = [
    {
      'title': 'Recent breakup, felt hopeless',
      'total': 478,
      'mood': 'Sad',
      'moodColor': Color(0xFFD96A2B),
      'avatar': Icons.show_chart,
    },
    {
      'title': 'Shitty Teacher at University',
      'total': 65,
      'mood': 'Happy',
      'moodColor': Color(0xFFF2C94C),
      'avatar': Icons.account_balance,
    },
    {
      'title': 'Just wanna stop existing...',
      'total': 17,
      'mood': 'Overjoyed',
      'moodColor': Color(0xFF6BBF59),
      'avatar': Icons.hourglass_empty,
    },
  ];

  final List<Map<String, dynamic>> trashChats = [
    {
      'title': 'More Xmas this Xmas…',
      'total': 8,
      'mood': 'Depressed',
      'moodColor': Color(0xFF9B59B6),
      'avatar': Icons.store,
    },
    {
      'title': 'Tired of this circus...',
      'total': 11,
      'mood': 'Neutral',
      'moodColor': Color(0xFF8D6E63),
      'avatar': Icons.remove_circle_outline,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headerColor =  Color(0xFFDB7B32);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: headerColor,
              borderRadius:  BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            padding:  EdgeInsets.only(
              top: 45,
              left: 20,
              right: 20,
              bottom: 22,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) =>  HomeScreen()),
                      ),
                      child: AnimatedContainer(
                        duration:  Duration(milliseconds: 180),
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.18),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.35),
                            width: 1,
                          ),
                        ),
                        child:  Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),

                 SizedBox(height: 20),

                Text(
                  'My AI Chats',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 34,
                  ),
                ),

                 SizedBox(height: 22),

                Container(
                  padding:  EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: headerColor.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    children: [
                   
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => activeSegment = 0),
                          child: AnimatedContainer(
                            duration:  Duration(milliseconds: 250),
                            padding:  EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: activeSegment == 0
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                'Recent',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: activeSegment == 0
                                      ? headerColor
                                      : Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                       SizedBox(width: 8),

                      
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => activeSegment = 1),
                          child: AnimatedContainer(
                            duration:  Duration(milliseconds: 250),
                            padding:  EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: activeSegment == 1
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                'Trash',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: activeSegment == 1
                                      ? headerColor
                                      : Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              color:  Color(0xFFF7F4F1),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        activeSegment == 0
                            ? 'Recent (${recentChats.length})'
                            : 'Trash (${trashChats.length})',
                        style:  TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                       Spacer(),
                      Text(
                        'See All',
                        style: TextStyle(
                          color: Colors.green[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                   SizedBox(height: 14),

                  Expanded(
                    child: ListView.separated(
                      itemCount: activeSegment == 0
                          ? recentChats.length
                          : trashChats.length,
                      separatorBuilder: (_, __) =>  SizedBox(height: 14),
                      itemBuilder: (_, index) {
                        final item = activeSegment == 0
                            ? recentChats[index]
                            : trashChats[index];

                        return Hero(
                          tag: "chat-card-$index",
                          child: ChatCard(
                            title: item['title'],
                            total: item['total'],
                            mood: item['mood'],
                            moodColor: item['moodColor'],
                            avatarIcon: item['avatar'],
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>  ChatScreen(),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

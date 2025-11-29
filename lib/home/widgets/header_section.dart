import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HeaderSection extends StatelessWidget {
  final String username; // added username parameter

  const HeaderSection({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFF4F3422),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row: date + bell
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'icons/Date_range_fill.png',
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(width: 6),
                      Text(
                        DateFormat('EEE, dd MMM yyyy').format(DateTime.now()),
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Image.asset('icons/bell.png', width: 60, height: 60),
                ],
              ),
              SizedBox(height: 8),
              // User info row
              Row(
                children: [
                  CircleAvatar(radius: 30),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, $username', // dynamic username
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset('icons/Star_fill.png'),
                          SizedBox(width: 4),
                          Text(
                            'Pro',
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 12),
                          Image.asset('icons/freud_icon.png'),
                          SizedBox(width: 4),
                          Text(
                            '80%',
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 12),
                          Image.asset('icons/happy.png'),
                          SizedBox(width: 4),
                          Text(
                            'Happy',
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Search field
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.search, color: Colors.grey),
                    hintText: 'Search anything..',
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:final_project/assessment/question6_meds.dart';

class Question5Physical extends StatefulWidget {
  @override
  _Question5PhysicalState createState() => _Question5PhysicalState();
}

class _Question5PhysicalState extends State<Question5Physical> {
  bool? _physicalDistress; // null sebleum dipilih

  void _goNext() {
    if (_physicalDistress == null) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Please choose an option')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Question6Medication(),
      ),
    );
  }

  Widget optionTile({
    required String label,
    required String description,
    required bool value,
  }) {
    final bool isSelected = _physicalDistress == value;
    const brown = Color(0xFF4B2E23);
    const green = Color(0xFFA8B86E);

    return GestureDetector(
      onTap: () => setState(() => _physicalDistress = value),
      child: AnimatedContainer(
        duration:  Duration(milliseconds: 250),
        curve: Curves.easeOut,
        margin:  EdgeInsets.only(bottom: 14),
        padding:  EdgeInsets.symmetric(vertical: 16, horizontal: 18),
        decoration: BoxDecoration(
          color: isSelected ? green : Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isSelected ? brown : brown.withOpacity(0.45),
            width: isSelected ? 2 : 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset:  Offset(0, 4),
                  )
                ]
              : [],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ICON LEFT
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.45),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isSelected ? Icons.close : Icons.check,
                color: brown,
                size: 22,
              ),
            ),
             SizedBox(width: 14),
            // TEXT LEFT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: brown,
                    ),
                  ),
                   SizedBox(height: 6),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: brown.withOpacity(0.7),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            // RADIO BUTTON RIGHT
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: brown,
              size: 26,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const brown = Color(0xFF4B2E23);

    return Scaffold(
      backgroundColor:  Color(0xFFF7F4F2),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
               SizedBox(height: 30),

              // HEADER ROW
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Assessment",
                    style: TextStyle(
                      color: brown,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Container(
                    padding:
                         EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color:  Color(0xFFEDEAE6),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      "5 of 7",
                      style: TextStyle(
                        fontSize: 14,
                        color: brown,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

               SizedBox(height: 40),

              // TITLE
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Are you experiencing any\nphysical distress?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: brown,
                    height: 1.3,
                  ),
                ),
              ),

               SizedBox(height: 32),

              // OPTIONS
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    optionTile(
                      label: "Yes, one or multiple",
                      description:
                          "I'm experiencing physical pain in different places over my body.",
                      value: true,
                    ),
                    optionTile(
                      label: "No Physical Pain At All",
                      description:
                          "I'm not experiencing any physical pain in my body at all :)",
                      value: false,
                    ),
                  ],
                ),
              ),

              // BUTTON
              Container(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _goNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brown,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child:  Text(
                    "Continue  →",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

               SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}

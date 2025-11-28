import 'package:flutter/material.dart';
import 'package:final_project/assesment/assesment_step2.dart';

class Question5Physical extends StatefulWidget {
  @override
  _Question5PhysicalState createState() => _Question5PhysicalState();
}

class _Question5PhysicalState extends State<Question5Physical> {
  String? selectedOption;

  void _goNext() {
    if (selectedOption == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please choose one option")),
      );
      return;
    }

    // convert "yes" / "no" to bool
    final bool physicalDistress = selectedOption == "yes";

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AssessmentStep2(physicalDistress: physicalDistress),
      ),
    );
  }

  Widget optionTile({
    required String label,
    required String description,
    required String value,
  }) {
    final bool isSelected = selectedOption == value;

    return GestureDetector(
      onTap: () => setState(() => selectedOption = value),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        margin: EdgeInsets.only(bottom: 18),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFA8B86E) : Color(0xFFF1F1F1),
          borderRadius: BorderRadius.circular(28),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isSelected ? Icons.close : Icons.check,
                color: Colors.brown,
                size: 22,
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.brown.withOpacity(0.7),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: Colors.white,
              size: 26,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.only(left: 16, top: 6, bottom: 6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.brown, width: 1.4),
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.brown),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 22),
            Text(
              "Are you experiencing any\nphysical distress?",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                height: 1.3,
                color: Colors.brown,
              ),
            ),
            SizedBox(height: 32),
            optionTile(
              label: "Yes, one or multiple",
              description:
                  "I'm experiencing physical pain in different places over my body.",
              value: "yes",
            ),
            optionTile(
              label: "No Physical Pain At All",
              description:
                  "I'm not experiencing any physical pain in my body at all :)",
              value: "no",
            ),
            Spacer(),
            Container(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: _goNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  disabledBackgroundColor: Colors.brown.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: Text(
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
    );
  }
}

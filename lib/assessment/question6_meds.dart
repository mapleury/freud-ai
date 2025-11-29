import 'package:flutter/material.dart';

class Question6Medication extends StatefulWidget {
  @override
  _Question6MedicationState createState() => _Question6MedicationState();
}

class _Question6MedicationState extends State<Question6Medication> {
  String? selected;

  Widget medOption({
    required String value,
    required IconData icon,
    required String label,
  }) {
    bool isSelected = selected == value;

    return GestureDetector(
      onTap: () => setState(() => selected = value),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFA8B86E) : Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: isSelected
              ? Border.all(color: Color(0xFF4B2E23), width: 2)
              : Border.all(color: Color(0xFF4B2E23).withOpacity(0.45), width: 1.5),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // pushes text to bottom
          children: [
            // ICON AT TOP LEFT
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.45),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Color(0xFF4B2E23), size: 22),
            ),

            // LABEL AT BOTTOM LEFT
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                height: 1.3,
                color: Color(0xFF4B2E23),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F4F2),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
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
                      color: Color(0xFF4B2E23),
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Color(0xFFEDEAE6),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      "6 of 7",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4B2E23),
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
                  "Are you taking any\nmedications?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    height: 1.3,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4B2E23),
                  ),
                ),
              ),
              SizedBox(height: 32),
              // GRID 2 × 2
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.92,
                  children: [
                    medOption(
                      value: "prescribed",
                      icon: Icons.medical_services_outlined,
                      label: "Prescribed\nMedications",
                    ),
                    medOption(
                      value: "supplements",
                      icon: Icons.local_hospital_outlined,
                      label: "Over the Counter\nSupplements",
                    ),
                    medOption(
                      value: "none",
                      icon: Icons.circle_outlined,
                      label: "I'm not taking any",
                    ),
                    medOption(
                      value: "skip",
                      icon: Icons.close,
                      label: "Prefer not to say",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              // BUTTON CONTINUE
              Container(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: selected == null
                      ? null
                      : () => Navigator.pushNamed(context, "/q7"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4B2E23),
                    disabledBackgroundColor: Color(0xFF4B2E23).withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Text(
                    "Continue  →",
                    style: TextStyle(fontSize: 18, color: Colors.white),
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

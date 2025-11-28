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
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ICON KECIL DI KIRI ATAS
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.45),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.brown, size: 22),
            ),

            SizedBox(height: 16),

            // TEKS LABEL
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                height: 1.3,
                color: Colors.brown,
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
      // APPBAR TANPA “9 of 14”
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),

            // TITLE
            Text(
              "Are you taking any\nmedications?",
              style: TextStyle(
                fontSize: 26,
                height: 1.3,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
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
                  backgroundColor: Colors.brown,
                  disabledBackgroundColor: Colors.brown.withOpacity(0.3),
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
    );
  }
}

import 'package:flutter/material.dart';
import 'expression_camera_page.dart';

class StressLevelPage extends StatefulWidget {
  const StressLevelPage({super.key});

  @override
  State<StressLevelPage> createState() => _StressLevelPageState();
}

class _StressLevelPageState extends State<StressLevelPage> {
  int selectedStress = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stress Level Input")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Pick your stress level (1 to 5):",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) {
                final value = index + 1;
                return GestureDetector(
                  onTap: () => setState(() => selectedStress = value),
                  child: CircleAvatar(
                    backgroundColor:
                        selectedStress == value ? Colors.deepPurple : Colors.grey,
                    child: Text(value.toString()),
                  ),
                );
              }),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ExpressionCameraPage(
                      stressLevel: selectedStress,
                    ),
                  ),
                );
              },
              child: const Text("Record Expression"),
            ),
            TextButton(
              onPressed: () {
                // You can save only the stress level here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Saved without recording expression.")),
                );
              },
              child: const Text("Skip Without Recording"),
            ),
          ],
        ),
      ),
    );
  }
}

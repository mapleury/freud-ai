import 'package:final_project/assesment/assesment_step2.dart';
import 'package:flutter/material.dart';

class AssessmentStep1 extends StatefulWidget {
  const AssessmentStep1({super.key});

  @override
  State<AssessmentStep1> createState() => _AssessmentStep1State();
}

class _AssessmentStep1State extends State<AssessmentStep1> {
  bool? _physicalDistress; // null until chosen

  void _goNext() {
    if (_physicalDistress == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please choose Yes or No')),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AssessmentStep2(physicalDistress: _physicalDistress!),
      ),
    );
  }

  Widget _choiceButton(String label, bool value) {
    final selected = _physicalDistress == value;
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: selected ? Colors.deepPurple : Colors.grey[200],
          foregroundColor: selected ? Colors.white : Colors.black87,
        ),
        onPressed: () => setState(() => _physicalDistress = value),
        child: Text(label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assessment — Step 1')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 18),
            const Text(
              'Are you experiencing physical distress?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                _choiceButton('Yes', true),
                const SizedBox(width: 12),
                _choiceButton('No', false),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _goNext,
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

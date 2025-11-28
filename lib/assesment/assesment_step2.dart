import 'package:flutter/material.dart';
import 'package:final_project/assesment/assesment_result.dart';
import 'package:final_project/auth/auth_service.dart';

class AssessmentStep2 extends StatefulWidget {
  final bool? physicalDistress;

  const AssessmentStep2({
    super.key,
    this.physicalDistress,
  });

  @override
  State<AssessmentStep2> createState() => _AssessmentStep2State();
}

class _AssessmentStep2State extends State<AssessmentStep2> {
  int _selected = 3;
  final _auth = AuthService();

  Widget _levelChip(int value) {
    final selected = _selected == value;

    return GestureDetector(
      onTap: () => setState(() => _selected = value),
      child: Container(
        width: 48,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? Colors.deepPurple : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          value.toString(),
          style: TextStyle(
            color: selected ? Colors.white : Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future<void> _goResult() async {
  final user = _auth.currentUser; 

  if (user != null) {
    await _auth.markAssessmentDone(user.uid);
  }

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => AssessmentResult(
        physicalDistress: widget.physicalDistress ?? false,
        stressLevel: _selected,
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assessment — Step 2')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 18),
            const Text(
              'How would you rate your stress level?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (i) => _levelChip(i + 1)),
            ),

            const Spacer(),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Back'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _goResult,
                    child: const Text('See Result'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

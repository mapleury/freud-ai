import 'package:final_project/assesment/assesment_model.dart';
import 'package:final_project/assesment/assesment_service.dart';
import 'package:final_project/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AssessmentResult extends StatefulWidget {
  final bool physicalDistress;
  final int stressLevel;
  final uid = FirebaseAuth.instance.currentUser!.uid;


   AssessmentResult({
    super.key,
    required this.physicalDistress,
    required this.stressLevel,
  });

  @override
  State<AssessmentResult> createState() => _AssessmentResultState();
}

class _AssessmentResultState extends State<AssessmentResult> {
  final AssessmentService _service = AssessmentService();
  bool _saving = false;
  bool _saved = false;
  String? _error;

  int get _score => widget.stressLevel + (widget.physicalDistress ? 2 : 0);

  Future<void> _save() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() => _error = 'You must be signed in to save results.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign in first to save assessment.')),
      );
      return;
    }

    setState(() {
      _saving = true;
      _error = null;
    });

    final model = AssessmentModel(
      uid: user.uid,
      physicalDistress: widget.physicalDistress,
      stressLevel: widget.stressLevel,
      score: _score,
      timestamp: DateTime.now(),
    );

    try {
      await _service.saveAssessment(model);
      setState(() {
        _saved = true;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Assessment saved.')));
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Save failed: $e')));
    } finally {
      setState(() => _saving = false);
    }
  }

  @override
  void initState() {
    super.initState();
    // Optionally autosave on open: comment/uncomment next line
    // _save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assessment Result')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Text(
              'Score: $_score',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Stress level: ${widget.stressLevel}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 6),
            Text(
              'Physical distress: ${widget.physicalDistress ? "Yes" : "No"}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            const Spacer(),
            if (_saved)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final uid = FirebaseAuth.instance.currentUser!.uid;

                        await AuthService().markAssessmentDone(uid);

                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      child: const Text('Done'),
                    ),
                  ),
                ],
              )
            else
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _saving ? null : () => Navigator.pop(context),
                      child: const Text('Back'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _saving ? null : _save,
                      child: _saving
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Save Result'),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

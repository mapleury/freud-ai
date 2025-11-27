
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_project/journal/journal_entry.dart';
import 'package:flutter/material.dart';
import 'journal_service.dart';
import 'emoji_picker.dart';

class CreateJournalScreen extends StatefulWidget {
  @override
  _CreateJournalScreenState createState() => _CreateJournalScreenState();
}

class _CreateJournalScreenState extends State<CreateJournalScreen> {
  final _titleCtrl = TextEditingController();
  final _contentCtrl = TextEditingController();
  int _stressLevel = 0;
  String _emoji = '😐';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Entry")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleCtrl,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _contentCtrl,
                decoration: InputDecoration(labelText: 'Content'),
                maxLines: 4,
              ),
              SizedBox(height: 20),
              Text("Emoji"),
              EmojiPicker(
                selected: _emoji,
                onSelect: (e) => setState(() => _emoji = e),
              ),
              SizedBox(height: 20),
              Text("Stress Level: $_stressLevel"),
              Slider(
                value: _stressLevel.toDouble(),
                min: 0,
                max: 100,
                onChanged: (v) => setState(() => _stressLevel = v.toInt()),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text("Save"),
                onPressed: () async {
                  final entry = JournalEntry(
                    id: '',
                    title: _titleCtrl.text,
                    content: _contentCtrl.text,
                    emoji: _emoji,
                    stressLevel: _stressLevel,
                    createdAt: DateTime.now(), uid: '${FirebaseAuth.instance.currentUser!.uid}',
                  );

                  await JournalService().createEntry(entry);
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

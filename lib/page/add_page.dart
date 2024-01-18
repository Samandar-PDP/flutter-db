import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_db/db/db_helper.dart';
import 'package:flutter_db/model/note.dart';
import 'package:intl/intl.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  
  late TextEditingController _titleController;
  late TextEditingController _descController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _descController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _saveNote() async {
    await DbHelper
        .saveNote(Note(title: _titleController.text, desc: _descController.text, date: _currentTime()));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal"),
        actions: [
          IconButton(onPressed: () {
            _saveNote().then((value) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Saved"))
              );
              Navigator.of(context).pop();
            });
          }, icon: const Icon(CupertinoIcons.check_mark))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Title",
                hintStyle: TextStyle(
                    fontSize: 22,
                    color: Colors.white
                ),
              ),
            ),
            const SizedBox(height: 4),
            Align(alignment: Alignment.centerLeft,child: Text(_currentTime()),),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Description",
                  hintStyle: TextStyle(
                      color: Colors.white60
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  String _currentTime() {
    final formatter = DateFormat("EEE, MM, yyyy");
    return formatter.format(DateTime.now());
  }
}

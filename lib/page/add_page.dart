import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_db/db/db_helper.dart';
import 'package:flutter_db/model/note.dart';
import 'package:flutter_db/page/home_page.dart';
import 'package:intl/intl.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key, required this.note});

  final Note? note;

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
    if (widget.note != null) {
      _titleController.text = widget.note?.title ?? "";
      _descController.text = widget.note?.desc ?? "";
    }
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _saveOrUpdate() async {
    String title = _titleController.text;
    if (title.isEmpty) {
      final int index = _descController.text.indexOf(" ");
      title = _descController.text.substring(0, index);
    }
    if(widget.note == null) {
      await DbHelper.saveNote(
          Note(title: title, desc: _descController.text, date: _currentTime()));
    } else {
      await DbHelper.updateNote(
        widget.note?.id,
          Note(id: widget.note?.id ,title: title, desc: _descController.text, date: _currentTime()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note != null ? "Update Note" : "Add New Note"),
        actions: [
          IconButton(
              onPressed: () {
                if (_descController.text.isNotEmpty) {
                  _saveOrUpdate().then((value) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(widget.note == null ? "Saved" : "Updated")));
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                        (route) => false);
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Enter data")));
                }
              },
              icon: const Icon(CupertinoIcons.check_mark))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              style: TextStyle(fontSize: 22, color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Title",
                hintStyle: TextStyle(fontSize: 22, color: Colors.white54),
              ),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(_currentTime()),
            ),
            Expanded(
              child: TextField(
                controller: _descController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Description",
                  hintStyle: TextStyle(color: Colors.white60),
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

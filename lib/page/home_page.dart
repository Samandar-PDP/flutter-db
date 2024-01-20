import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_db/db/db_helper.dart';
import 'package:flutter_db/model/note.dart';
import 'dart:math' as math;

import 'package:flutter_db/page/add_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.search))
        ],
      ),
      body: FutureBuilder(
        future: DbHelper.getNotes(),
        builder: (context, snapshot) {
          if(snapshot.data != null && snapshot.data?.isNotEmpty == true) {
            final list = snapshot.data?.reversed.toList();
           return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return _noteItem(list?[index]);
              },
            );
          } else {
            return const Center(child: Icon(CupertinoIcons.hourglass));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CupertinoColors.activeOrange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: const Icon(CupertinoIcons.add,color: Colors.white,),
        onPressed: () {
          Navigator.of(context).push(
            CupertinoPageRoute(builder: (context) => AddPage(note: null))
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  Widget _noteItem(Note? note) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            CupertinoPageRoute(builder: (context) => AddPage(note: note))
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1), width: 2),
            borderRadius: BorderRadius.circular(12)
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(note?.title ?? "",style: const TextStyle(fontSize: 22, color: Colors.white)),
                    const SizedBox(height: 5),
                    Text(note?.desc ?? ""),
                    const SizedBox(height: 5),
                    Text(note?.date ?? ""),
                  ],
                ),
              ),
              IconButton(onPressed: () => _deleteNote(note?.id), icon: const Icon(CupertinoIcons.delete,color: Colors.red))
            ],
          )
        ),
      ),
    );
  }
  void _deleteNote(int? id) {
    showCupertinoDialog(context: context, barrierDismissible: true,builder: (dialogContext) => CupertinoAlertDialog(
      title: const Text("Delete?"),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
            child: Text("No")),
    CupertinoDialogAction(
    onPressed: () {
      DbHelper.deleteNote(id).then((value) {
        setState(() {});
        Navigator.pop(context);
      });
    },
    child: Text("Yes")),
      ],
    ));
  }
}

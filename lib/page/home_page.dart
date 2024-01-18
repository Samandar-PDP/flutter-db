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
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return _noteItem(Note(title: "$index", desc: "$index", date: "$index"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CupertinoColors.activeOrange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: const Icon(CupertinoIcons.add,color: Colors.white,),
        onPressed: () {
          Navigator.of(context).push(
            CupertinoPageRoute(builder: (context) => AddPage())
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  Widget _noteItem(Note note) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1), width: 2),
            borderRadius: BorderRadius.circular(12)
          ),
          child: Column(
            children: [
              Text(note.title,style: TextStyle(fontSize: 22, color: Colors.white)),
              const SizedBox(height: 5),
              Text(note.desc),
              const SizedBox(height: 5),
              Text(note.date),
            ],
          ),
        ),
      ),
    );
  }
}

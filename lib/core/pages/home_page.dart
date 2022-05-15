// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:dairy_app/features/notes/domain/entities/notes.dart';
import 'package:dairy_app/features/notes/presentation/pages/note_create_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

var notes = [
  Note(
    id: "1",
    createdAt: DateTime.now(),
    title: "This is test title",
    body: "This is test body, this is test body, this is test body",
  ),
  Note(
    id: "2",
    createdAt: DateTime.now(),
    title: "This is test title",
    body: "This is test body, this is test body, this is test body",
  ),
  Note(
    id: "3",
    createdAt: DateTime.now(),
    title: "This is test title",
    body: "This is test body, this is test body, this is test body",
  ),
  Note(
    id: "4",
    createdAt: DateTime.now(),
    title: "This is test title",
    body: "This is test body, this is test body, this is test body",
  ),
  Note(
    id: "5",
    createdAt: DateTime.now(),
    title: "This is test title",
    body: "This is test body, this is test body, this is test body",
  ),
  Note(
    id: "6",
    createdAt: DateTime.now(),
    title: "This is test title",
    body: "This is test body, this is test body, this is test body",
  ),
  Note(
    id: "7",
    createdAt: DateTime.now(),
    title: "This is test title",
    body: "This is test body, this is test body, this is test body",
  ),
  Note(
    id: "8",
    createdAt: DateTime.now(),
    title: "This is test title",
    body: "This is test body, this is test body, this is test body",
  ),
  Note(
    id: "9",
    createdAt: DateTime.now(),
    title: "This is test title",
    body: "This is test body, this is test body, this is test body",
  ),
  Note(
    id: "10",
    createdAt: DateTime.now(),
    title: "This is test title",
    body: "This is test body, this is test body, this is test body",
  ),
  Note(
    id: "11",
    createdAt: DateTime.now(),
    title: "This is test title",
    body: "This is test body, this is test body, this is test body",
  ),
  Note(
    id: "12",
    createdAt: DateTime.now(),
    title: "This is test title",
    body: "This is test body, this is test body, this is test body",
  ),
];

class HomePage extends StatelessWidget {
  static String get route => '/';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          leading: Icon(Icons.line_weight_outlined),
          actions: [
            Icon(Icons.search),
          ],
          backgroundColor: Colors.pink[100],
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              "assets/images/digital-art-neon-bubbles.jpg",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          expandedHeight: 200,
          pinned: true,
        ),
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return ListTile(
              title: Text(notes[index].title + " $index"),
              subtitle: Text(notes[index].body),
            );
          }, childCount: 12),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(NoteCreatePage.route);
        },
      ),
    );
  }
}

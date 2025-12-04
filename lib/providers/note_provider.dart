import 'package:flutter/material.dart';
import '../database/note_database.dart';
import '../models/note.dart';

class NoteProvider with ChangeNotifier {
  List<Note> notes = [];

  Future loadNotes() async {
    final box = await NoteDatabase.box();
    notes = box.values.toList();
    notifyListeners();
  }

  Future add(Note note) async {
    await NoteDatabase.addNote(note);
    loadNotes();
  }

  Future update(int index, Note n) async {
    await NoteDatabase.updateNote(index, n);
    loadNotes();
  }

  Future remove(int index) async {
    await NoteDatabase.deleteNote(index);
    loadNotes();
  }
}

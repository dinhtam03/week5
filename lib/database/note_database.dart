import 'package:hive/hive.dart';
import '../models/note.dart';

class NoteDatabase {
  static String boxName = "notes_box";

  static Future<Box<Note>> box() async {
    return await Hive.openBox<Note>(boxName);
  }

  static Future<void> addNote(Note note) async {
    final box = await NoteDatabase.box();
    box.add(note);
  }

  static Future<void> updateNote(int index, Note note) async {
    final box = await NoteDatabase.box();
    box.put(index, note);
  }

  static Future<void> deleteNote(int index) async {
    final box = await NoteDatabase.box();
    box.deleteAt(index);
  }
}

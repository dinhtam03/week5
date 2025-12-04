import 'package:hive/hive.dart';
import 'note.dart';

class NoteAdapter extends TypeAdapter<Note> {
  @override
  final int typeId = 0;

  @override
  Note read(BinaryReader reader) {
    return Note(
      title: reader.readString(),
      content: reader.readString(),
      date: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Note obj) {
    writer.writeString(obj.title);
    writer.writeString(obj.content);
    writer.writeString(obj.date);
  }
}

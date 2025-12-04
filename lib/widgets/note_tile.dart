import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import '../screens/note_editor.dart';

class NoteTile extends StatelessWidget {
  final int index;
  const NoteTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<NoteProvider>(context).notes;

    return ListTile(
      title: Text(notes[index].title, maxLines: 1),
      subtitle: Text(notes[index].date),
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => NoteEditor(index: index, note: notes[index]))),
      trailing: IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: () => Provider.of<NoteProvider>(context, listen: false).remove(index),
      ),
    );
  }
}

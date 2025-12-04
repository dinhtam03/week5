import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import '../models/note.dart';

class NoteEditor extends StatefulWidget {
  final int? index;
  final Note? note;

  const NoteEditor({super.key, this.index, this.note});

  @override
  State<NoteEditor> createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      title.text = widget.note!.title;
      content.text = widget.note!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.note == null ? "Thêm ghi chú" : "Sửa")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          final note = Note(
            title: title.text,
            content: content.text,
            date: DateTime.now().toIso8601String(),
          );

          final provider = Provider.of<NoteProvider>(context, listen: false);

          widget.note == null
              ? provider.add(note)
              : provider.update(widget.index!, note);

          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: title, decoration: InputDecoration(labelText: "Tiêu đề")),
            SizedBox(height: 10),
            TextField(controller: content, maxLines: 10, decoration: InputDecoration(labelText: "Nội dung")),
          ],
        ),
      ),
    );
  }
}

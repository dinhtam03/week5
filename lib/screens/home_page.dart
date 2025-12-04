import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import 'note_editor.dart';
import '../widgets/note_tile.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoteProvider>(context, listen: false).loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("📒 My Notes")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => NoteEditor()));
        },
        child: Icon(Icons.add),
      ),
      body: Consumer<NoteProvider>(
        builder: (context, provider, child) {
          return provider.notes.isEmpty
              ? Center(child: Text("Chưa có ghi chú!"))
              : ListView.builder(
            itemCount: provider.notes.length,
            itemBuilder: (_, i) => NoteTile(index: i),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/note.dart';
import 'models/note_adapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(NoteAdapter());      // KHÔNG cần note.g.dart
  await Hive.openBox<Note>('notes');        // mở box note

  runApp(const MyApp());
}

// ------------------- FIX LỖI Ở ĐÂY -------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

// ------------------- Màn hình chính -------------------
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  final box = Hive.box<Note>('notes');

  addNote() {
    final note = Note(
      title: titleController.text,
      content: contentController.text,
      date: DateTime.now().toString(),
    );
    box.add(note);
    titleController.clear();
    contentController.clear();
    Navigator.pop(context);
  }

  openAddDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Thêm ghi chú"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: "Tiêu đề")),
            TextField(controller: contentController, decoration: const InputDecoration(labelText: "Nội dung")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Hủy")),
          ElevatedButton(onPressed: addNote, child: const Text("Lưu")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Note App ❤")),
      floatingActionButton: FloatingActionButton(
        onPressed: openAddDialog,
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (_, data, __) {
          if (box.isEmpty) return const Center(child: Text("Chưa có ghi chú"));

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (_, i) {
              final note = box.getAt(i);
              return ListTile(
                title: Text(note!.title),
                subtitle: Text(note.content),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => box.deleteAt(i),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

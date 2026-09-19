import 'package:flutter/material.dart';
import 'package:org_kata_agendaparticular/screens/note_detail_screen.dart';

@HiveType(typeId: 0)
@HiveField(0)
class Note {
  @HiveField(1)
  final String title;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final String activity;

  Note(this.title, this.date, this.activity);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Note> _notes = [];
  List<Note> _filteredNotes = [];
  final Box<Note> _noteBox = Hive.box<Note>('notes');

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  void _loadNotes() {
    setState(() {
      _notes.clear();
      _filteredNotes.clear();
      _notes.addAll(_noteBox.values);
      _filteredNotes.addAll(_notes);
    });
  }

  void _addNote() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NoteDetailScreen(addMode: true),
        fullscreenDialog: true,
      ),
    ).then((_) => _loadNotes());
  }

  void _filterNotes() {
    final searchTerm = _searchController.text.toLowerCase();
    setState(() {
      _filteredNotes = _notes.where((note) {
        return note.title.toLowerCase().contains(searchTerm) ||
               note.activity.toLowerCase().contains(searchTerm) ||
               note.date.toString().contains(searchTerm);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda Particular'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _filterNotes,
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Pesquisar anotações...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => _filterNotes(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredNotes.length,
              itemBuilder: (context, index) {
                final note = _filteredNotes[index];
                return ListTile(
                  title: Text(note.title),
                  subtitle: Text('${note.date.day}/${note.date.month}/${note.date.year} - ${note.activity}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoteDetailScreen(note: note),
                      ),
                    ).then((_) => _loadNotes());
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        tooltip: 'Adicionar anotação',
        child: const Icon(Icons.add),
      ),
    );
  }
}

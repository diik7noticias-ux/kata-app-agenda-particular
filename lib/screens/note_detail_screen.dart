import 'package:flutter/material.dart';
import 'package:org_kata_agendaparticular/models/note.dart';

class NoteDetailScreen extends StatefulWidget {
  final Note? note;
  final bool addMode;

  const NoteDetailScreen({super.key, this.note, this.addMode = false});

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late TextEditingController _titleController;
  late TextEditingController _activityController;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _activityController = TextEditingController(text: widget.note?.activity ?? '');
    _selectedDate = widget.note?.date ?? DateTime.now();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _activityController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.addMode ? 'Nova Anotação' : 'Editar Anotação'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final note = Note(
                _titleController.text,
                _activityController.text,
                _selectedDate,
              );
              Navigator.pop(context, note);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _activityController,
              decoration: const InputDecoration(
                labelText: 'Atividade',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Text('Data: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: const Text('Selecionar Data'),
            ),
          ],
        ),
      ),
    );
  }
}
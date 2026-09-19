import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'theme.dart';
import 'models/note.dart';
import 'screens/home_screen.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>('notes');
  runApp(const KataApp());
}

class KataApp extends StatelessWidget {
  const KataApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Agenda Particular",
      debugShowCheckedModeBanner: false,
      theme: buildKataTheme(),
      home: const HomeScreen(),
    );
  }
}
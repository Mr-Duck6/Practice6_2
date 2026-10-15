import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/board_model.dart';
import 'state/filter_model.dart';
import 'screens/board_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BoardModel()),
        ChangeNotifierProvider(create: (_) => FilterModel()),
      ],
      child: MaterialApp(
        title: 'Kanban Board Provider',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const BoardScreen(),
      ),
    );
  }
}
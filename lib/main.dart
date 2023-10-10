import 'package:flutter/material.dart';
import 'package:lineupmaster/main_screen.dart';
import 'package:lineupmaster/providers/page_index.dart';
import 'package:lineupmaster/providers/page_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PageIndexModel()),
        ChangeNotifierProvider(create: (_) => PageScreenModel()),
      ],
      child: const MyApp()
    )
  );  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LineUpMaster',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}


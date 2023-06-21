import 'dart:io';
import 'package:hive/hive.dart';
import 'package:hivedatabase/home_screen.dart';
import 'package:hivedatabase/todo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  //Register the adapter
  Hive.registerAdapter(TodoAdapter());
  //open a new box with Todo data
  await Hive.openBox<Todo>('todo');
  await Hive.openBox('friend'); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

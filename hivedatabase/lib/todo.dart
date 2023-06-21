import 'package:hive/hive.dart';
part 'todo.g.dart';

@HiveType(typeId: 1)

class Todo{
  @HiveField(0)
  final String title;
  @HiveField(1)
  final bool isCompleted;
  @HiveField(2)
  String ?description;

  Todo({required this.isCompleted,  required this.title, this.description});

  putAt(int ids, Todo newModelss) {}
}
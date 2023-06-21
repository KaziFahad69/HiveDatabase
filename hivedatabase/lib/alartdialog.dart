import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hivedatabase/todo.dart';

class AlartDiologg extends StatefulWidget {
  //const AlartDiologg({super.key});
  int id;
  final Todo todo;

  AlartDiologg({required this.todo, required this.id});

  @override
  State<AlartDiologg> createState() => _AlartDiologgState();
}

class _AlartDiologgState extends State<AlartDiologg> {
  TextEditingController? _descriptionController;
  TextEditingController? _textEditingController;
  String? title;
  Box todoBox = Hive.box<Todo>('todo');

  @override
  void initState() {
    // TODO: implement initState
    _textEditingController = TextEditingController(text: widget.todo.title);
    _descriptionController =
        TextEditingController(text: widget.todo.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var ids = widget.id;
    return AlertDialog(
      
      title: Text('Update'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DecoratedTextField(
              controller: _textEditingController, label: "Enter updated title"),
          SizedBox(
            height: 14.5,
          ),
          DecoratedTextField(
              maxLines: 3,
              controller: _descriptionController, label: "Enter updated description"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            Todo newModelss = Todo(isCompleted: false,
              title: _textEditingController!.text,
              description: _descriptionController!.text,
            );
            if (_textEditingController!.text != '') {
              await todoBox.putAt(ids, newModelss);
            }

            Navigator.pop(context);
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}

class DecoratedTextField extends StatelessWidget {
  final String label;
  TextEditingController? controller;
  int ?maxLines;

  DecoratedTextField({required this.label, this.controller, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}

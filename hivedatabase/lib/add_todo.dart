//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hivedatabase/todo.dart';

class AddTodo extends StatefulWidget {
  AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Box todoBox = Hive.box<Todo>('todo');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Enter your Task!!",
                style: TextStyle(
                  fontSize: 26,
                ),
              ),
              Container(
                  height: MediaQuery.of(context).size.height * .3,
                  width: double.infinity,
                  child: Image.asset('images/todo.jpg')),
              TextField(
                //autofocus: true,
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Enter title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: TextField(
                  //autofocus: true,
                  maxLines: 3,
                  controller: descriptionController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Description'),
                ),
              ),

              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  if (titleController.text != '') {
                    Todo newTodo =
                        Todo(isCompleted: false, title: titleController.text, description: descriptionController.text);
                    todoBox.add(newTodo);
                    Navigator.pop(context);
                    setState(() {
                      
                    });
                  }
                  else if (titleController.text == ''){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Title Cannot Be Empty'),)
                              );
                            }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: double.infinity,
                  child: Text(
                    "Add ToDo",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

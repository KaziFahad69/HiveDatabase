//import 'dart:js_interop';

//import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hivedatabase/add_todo.dart';
import 'package:hivedatabase/alartdialog.dart';
import 'package:hivedatabase/showmodalbotomsheet.dart';
import 'package:hivedatabase/todo.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);

  final Todo todo = Todo(title: 'My Todo', isCompleted: false);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Box friendbox = Hive.box('friend');
  // String? name;
  // addFirend()async{
  //   await friendbox.put('name', "Kazi Fahad");
  // }
  // getFriend()async{
  //   setState(() {
  //   });
  //   name = friendbox.get('name');
  // }
  // updateFreind()async{
  //   await friendbox.put('name', "Jahidul");
  // }
  // deleteFriend()async{
  //   await friendbox.delete('name');
  // }

  Box todoBox = Hive.box<Todo>('todo');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple[300],
        title: Text(
          "Note",
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
        Icon(Icons.hive)
        ],
        leading: Icon(Icons.menu),
      ),
      body:

          // Container(
          //   // width: MediaQuery.of(context).size.width,
          //   // child: Column(
          //   //   mainAxisAlignment: MainAxisAlignment.center,
          //   //   children: [
          //   //     // Text("$name"),
          //   //     // ElevatedButton(onPressed: () {addFirend();}, child: Text('Create',selectionColor: Colors.black,)),
          //   //     // ElevatedButton(onPressed: () {getFriend();}, child: Text('Read',selectionColor: Colors.black,)),
          //   //     // ElevatedButton(onPressed: () {updateFreind();}, child: Text('Update',selectionColor: Colors.black,)),
          //   //     // ElevatedButton(onPressed: () {deleteFriend();}, child: Text('Delete',selectionColor: Colors.black,)),
          //   //   ],
          //   // ),
          // ),
          ValueListenableBuilder(
              valueListenable: todoBox.listenable(),
              builder: (context, Box box, widget) {
                if (box.isEmpty) {
                  return Center(
                    child: Text(
                      "No Task available!!",
                      style: style(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  );
                } else {
                  return ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      itemCount: box.length,
                      itemBuilder: (context, index) {
                        Todo todo = box.getAt(index);
                        return GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: (context),
                              builder: (BuildContext context) => Show(id:index, todo: todo,)
                            );
                          },
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  todo.title, textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: todo.isCompleted
                                        ? Colors.green
                                        : Colors.red,
                                    decoration: todo.isCompleted
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                                Text(
                                  todo.description.toString(), textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: todo.isCompleted
                                        ? Colors.green
                                        : Colors.black,
                                    decoration: todo.isCompleted
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                              ],
                            ),
                            leading: 
                            
                            Checkbox(
                              
                                value: todo.isCompleted,
                                onChanged: (value) {
                                  Todo newtodo = Todo(
                                      isCompleted: value!,
                                      title: todo.title,
                                      description: todo.description);
                                  box.putAt(index, newtodo);
                                }),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                    onTap: () {
                                      box.deleteAt(index);
                                      setState(() {});
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text("Todo Deleted")));
                                    },
                                    child: Icon(Icons.delete)),
                                SizedBox(
                                    width:
                                        20), // Adjust the spacing between the icons if needed
                                InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlartDiologg(
                                            todo: todo,
                                            id: index,
                                          );
                                        },
                                      );
                                    },
                                    child: Icon(Icons.edit)),
                              ],
                            ),
                          ),
                        );
                      });
                }
              }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddTodo()));
          }),
    );
  }
}

TextStyle style({
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  TextDecoration? decoration,
}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    decoration: decoration,
  );
}

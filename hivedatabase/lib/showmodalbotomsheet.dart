import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hivedatabase/todo.dart';

class Show extends StatefulWidget {

  int id;
  final Todo todo;
  Show({required this.todo, required this.id});

  @override
  State<Show> createState() => _ShowState();
}

class _ShowState extends State<Show> {


    TextEditingController? _titlecontroller;
    TextEditingController? _descriptioncontroller;
    Box todoBox = Hive.box<Todo>('todo');

     @override
  void initState() {
    _titlecontroller = TextEditingController();
    _descriptioncontroller = TextEditingController();
    super.initState();
  }

    @override
  void dispose() {
    _titlecontroller!.dispose();
    _descriptioncontroller!.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {


    _titlecontroller!.text = '${widget.todo.title}';
    _descriptioncontroller!.text = '${widget.todo.description}';
    var ids = widget.id;
 


    return Container(
      height: MediaQuery.of(context).size.height*.9,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Your Task',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              
              Text("Title: ", textAlign: TextAlign.justify, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 186, 230, 83),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                width: MediaQuery.of(context).size.width*.6,
                child: Text('${widget.todo.title}')),
            ],),
            
            // TextField(
            //   decoration: InputDecoration(
            //     labelText: 'Title',
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            SizedBox(height: 20),
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text("Description: ", textAlign: TextAlign.justify,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 99, 216, 162),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                height: MediaQuery.of(context).size.height*.3,
                width: MediaQuery.of(context).size.width*.6,
                child: Text('${widget.todo.description!}')),
            ],),
            
            // TextField(
            //   maxLines: 3,
            //   decoration: InputDecoration(
            //     labelText: 'Description',
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            // SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: () {
            //     // Handle button press
            //   },
            //   child: GestureDetector(
            //     onTap: (){
            //       Navigator.pop(context);
            //     },
            //     child: Text('Exit')),
            // ),
          ],
        ),
      );
  }
}
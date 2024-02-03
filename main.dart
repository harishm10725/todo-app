import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Tasks {
  String? thing;
  bool? f;

  Tasks(this.thing, this.f);
}

class TodoApp extends StatefulWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  List<Tasks> tasks = [];
  late TextEditingController myController;

  @override
  void initState() {
    super.initState();
    myController = TextEditingController();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void addTask() {
    setState(() {
      tasks.add(Tasks(myController.text, false));
      myController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.lightBlueAccent, Colors.pinkAccent, Colors.white10]),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: myController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black87)),
                      hintText: "Enter the work to do ",
                    ),
                  ),
                ),
              ),
              Container(
                height: 60,
                child: ElevatedButton(
                  onPressed: addTask,
                  child: Container(
                    child: Icon(Icons.add),
                  ),
                ),
                padding: EdgeInsets.only(right: 5),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Checkbox(
                    value: tasks[index].f,
                    onChanged: (value) {
                      setState(() {
                        tasks[index].f = value!;
                      });
                    },
                  ),
                  title: Text("${tasks[index].thing}",style: TextStyle(decoration: tasks[index].f!?TextDecoration.lineThrough:TextDecoration.none),),
                  trailing: IconButton(
                    icon: Icon(Icons.delete_outline),
                    onPressed: () {
                      setState(() {
                        tasks.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.black87),
      home: TodoApp(),
    );
  }
}

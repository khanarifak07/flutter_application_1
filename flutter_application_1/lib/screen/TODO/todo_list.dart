import 'package:flutter/material.dart';
import 'package:flutter_application_1/Utilities/utilities.dart';
import 'package:flutter_application_1/model/todo_model.dart';
import 'package:flutter_application_1/screen/TODO/todo_form.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<TodoModel> todo = [];

  @override
  void initState() {
    fetchTodos();
    super.initState();
  }

  Future<void> fetchTodos() async {
    var todos = await Utilities.getTodosFromSharedPreference();
    setState(() {
      todo = todos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: todo.isEmpty
          ? const Center(
              child: Text("NO TODO"),
            )
          : ListView.builder(
              itemCount: todo.length,
              itemBuilder: (context, index) {
                var data = todo[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: const BehindMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (value) async {
                            todo.removeAt(index);
                            await Utilities.saveTodoToSharedPreference(todo);
                            setState(() {});
                          },
                          backgroundColor: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                          icon: Icons.delete,
                        )
                      ],
                    ),
                    startActionPane: ActionPane(
                      motion: const BehindMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (val) async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TodoForm(
                                  index: index,
                                  todoModel: todo[index],
                                ),
                              ),
                            );
                          },
                          icon: Icons.edit,
                          backgroundColor: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        )
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TodoForm(
                              todoModel: data,
                              index: index,
                            ),
                          ),
                        );
                        await fetchTodos();
                      },
                      // trailing: IconButton(
                      //     onPressed: () async {
                      //       todo.removeAt(index);
                      //       await Utilities.saveTodoToSharedPreference(todo);
                      //       setState(() {});
                      //     },
                      //     icon: const Icon(Icons.delete)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      tileColor: data.priority == 'High'
                          ? Colors.red.shade100
                          : data.priority == 'Medium'
                              ? Colors.blue.shade100
                              : data.priority == "Low"
                                  ? Colors.green.shade100
                                  : Colors.white,
                      title: Text(data.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data.description),
                          Text(Utilities.dateFormat.format(data.dateTime))
                        ],
                      ),
                    ),
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const TodoForm()));
          await fetchTodos();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

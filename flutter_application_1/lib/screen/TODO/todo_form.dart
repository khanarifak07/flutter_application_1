import 'package:flutter/material.dart';
import 'package:flutter_application_1/Utilities/utilities.dart';
import 'package:flutter_application_1/model/todo_model.dart';
import 'package:intl/intl.dart';

class TodoForm extends StatefulWidget {
  final TodoModel? todoModel;
  final int? index;
  const TodoForm({super.key, this.todoModel, this.index});

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  late final titleCtrl = TextEditingController(text: widget.todoModel?.title);
  late final descriptionCtrl =
      TextEditingController(text: widget.todoModel?.description);
  late DateTime selectedDate = widget.todoModel?.dateTime ?? DateTime.now();
  late String selectedPriority = widget.todoModel?.priority ?? "";
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  Future<void> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2040),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(widget.todoModel == null ? "Add Todo" : "Update Todo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "title",
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionCtrl,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "description",
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                selectDate(context);
              },
              child: TextField(
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: dateFormat.format(selectedDate),
                    enabled: false),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                colorContainer('High'),
                colorContainer('Medium'),
                colorContainer('Low'),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (titleCtrl.text.isEmpty && descriptionCtrl.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please add title and description to save"),
                    ),
                  );
                } else {
                  //get the todos from shared pref
                  List<TodoModel> todos =
                      await Utilities.getTodosFromSharedPreference();

                  if (widget.todoModel == null) {
                    //create new todo
                    TodoModel newTodo = TodoModel(
                      title: titleCtrl.text,
                      description: descriptionCtrl.text,
                      dateTime: selectedDate,
                      priority: selectedPriority,
                    );
                    //add new todo to list of todomodel
                    todos.add(newTodo);
                    //save todo to shared pref
                    await Utilities.saveTodoToSharedPreference(todos);
                    Navigator.pop(context);
                  } else {
                    //update todo
                    int? index = widget.index;
                    if (index != null) {
                      todos[index] = TodoModel(
                        title: titleCtrl.text,
                        description: descriptionCtrl.text,
                        dateTime: selectedDate,
                        priority: selectedPriority,
                      );
                    }
                    //save todo to shared pref
                    await Utilities.saveTodoToSharedPreference(todos);
                    Navigator.pop(context);
                  }
                }
              },
              child: Text(widget.todoModel == null ? "Save" : "Update"),
            ),
          ],
        ),
      ),
    );
  }

  Widget colorContainer(String priority) {
    Color colorContainer = getPriorityColor(priority);
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPriority = priority;
        });
      },
      child: Container(
        height: 50,
        width: 120,
        decoration: BoxDecoration(
          color: colorContainer,
          border: Border.all(
              color: selectedPriority == priority
                  ? Colors.black
                  : Colors.transparent,
              width: 2),
        ),
        child: Center(
          child: Text(priority),
        ),
      ),
    );
  }

  getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.blue;
      case 'Low':
        return Colors.green;
      default:
        return Colors.white;
    }
  }
}

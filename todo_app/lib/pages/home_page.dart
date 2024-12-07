import 'package:flutter/material.dart';
import 'package:todo_app/service/database_service.dart';

import '../models/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService _databaseService = DatabaseService.instance;

  String? _task = null;
  late Future<List<Task>> _tasksFuture; // State variable for Future

  @override
  void initState() {
    super.initState();
    _tasksFuture = _databaseService.getTasks(); // Initialize Future
  }

  void _refreshTasks() {
    setState(() {
      _tasksFuture = _databaseService.getTasks(); // Update Future
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Todo List",
          textAlign: TextAlign.center,
          ),
      ),
      floatingActionButton: _addTaskButton(),
      body: _tasksList(),
    );
  }

  Widget _addTaskButton() {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Add Task'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) => setState(() {
                    _task = value;
                  }),
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Add task'),
                ),
                MaterialButton(
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    if (_task == null || _task == "") return;
                    _databaseService.addTask(_task!);
                    setState(() {
                      _task = null;
                    });
                    Navigator.pop(
                      context,
                    );
                  },
                  child: const Text(
                    "Done",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }

  Widget _tasksList() {
    return FutureBuilder(
        future: _databaseService.getTasks(),
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                Task task = snapshot.data![index];
                return ListTile(
                  title: Text(
                    task.content,
                  ),
                  trailing: Checkbox(
                    value: task.status == 1, 
                    onChanged: (value) {
                      _databaseService.UpdateTaskStatus(task.id, value == true ? 1 : 0);
                      _refreshTasks();
                    }),
                );
              });
        });
  }
}

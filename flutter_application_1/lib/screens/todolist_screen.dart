import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../controllers/todolist_controller.dart';
import '../models/todolist.dart';
import '../services/auth_service.dart';

class TodolistScreen extends StatefulWidget {
  final User user;
  const TodolistScreen({super.key, required this.user});

  @override
  State<TodolistScreen> createState() => _TodolistScreenState();
}

class _TodolistScreenState extends State<TodolistScreen> {
  final AuthService _service =AuthService();
  final TextEditingController _taskController = TextEditingController();
  final TodolistController _todolistController = TodolistController();

  @override
  void initState() {
    super.initState();
    _getList();
  }

  Future<void> _getList() async{
    try {
      await _todolistController.fetchList(widget.user.uid);

    } catch (e) {
      print(e);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _service.logoutUsuario();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(labelText: 'New Task'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () async {
                    if (_taskController.text.isNotEmpty) {
                      final tarefa = Todolist(
                        id: '',
                        titulo: _taskController.text,
                        userId: widget.user.uid,
                        timestamp: DateTime.now(),
                      );
                      await _todolistController.add(tarefa);
                      _taskController.clear();
                      await _getList();
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _getList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (_todolistController.list.isEmpty) {
                  return const Center(child: Text('No tasks found.'));
                }

                return ListView.builder(
                  itemCount: _todolistController.list.length,
                  itemBuilder: (context, index) {
                    final tarefa = _todolistController.list[index];
                    return ListTile(
                      title: Text(tarefa.titulo),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await _todolistController.delete(tarefa.id);
                          await _getList();
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
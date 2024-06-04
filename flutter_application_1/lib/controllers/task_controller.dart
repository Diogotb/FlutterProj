import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';

class TaskController with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  Future<void> fetchTasks(String userId) async {
    final snapshot = await _firestore
        .collection('tasks')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .get();

    _tasks = snapshot.docs
        .map((doc) => Task.fromMap(doc.data(), doc.id))
        .toList();

    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    final docRef = await _firestore.collection('tasks').add(task.toMap());
    task.id = docRef.id;
    _tasks.insert(0, task);
    notifyListeners();
  }

  Future<void> deleteTask(String taskId) async {
    await _firestore.collection('tasks').doc(taskId).delete();
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }
}

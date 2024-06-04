import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String id;
  String task;
  String userId;
  DateTime timestamp;

  Task({
    required this.id,
    required this.task,
    required this.userId,
    required this.timestamp,
  });

  factory Task.fromMap(Map<String, dynamic> data, String id) {
    return Task(
      id: id,
      task: data['task'],
      userId: data['userId'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'task': task,
      'userId': userId,
      'timestamp': timestamp,
    };
  }
}

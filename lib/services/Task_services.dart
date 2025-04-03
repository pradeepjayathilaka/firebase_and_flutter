import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_and_flutter/model/task_model.dart';

class TaskServices {
  final CollectionReference _taskCollection = FirebaseFirestore.instance
      .collection("tasks");

  //Method to add a new task to the Firestore collection
  Future<void> addTask(String name) async {
    try {
      final task = Task(
        id: "",
        name: name,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isUpdated: false,
      );
      //convert the task to a map
      final Map<String, dynamic> data = task.toJson();

      await _taskCollection.add(data);

      print("Task added");
    } catch (error) {
      print("Error adding task: $error");
    }
  }

  //Method to get all the tasks from the Firestore collection
  Stream<List<Task>> getTasks() {
    return _taskCollection.snapshots().map(
      (snapshot) =>
          snapshot.docs
              .map(
                (doc) =>
                    Task.fromJson(doc.data() as Map<String, dynamic>, doc.id),
              )
              .toList(),
    );
  }

  //Method to update a task in the Firestore collection
  Future<void> updateTask(Task task) async {
    final Map<String, dynamic> data = task.toJson();
    try {
      await _taskCollection.doc(task.id).update(data);
      print("Task updated");
    } catch (error) {
      print("Error updating task: $error");
    }
  }

  //Method to Delete a task in the Firestore collection
  Future<void> deleteTask(String id) async {
    try {
      await _taskCollection.doc(id).delete();
      print("Task deleted");
    } catch (error) {
      print("Error deleting task: $error");
    }
  }
}

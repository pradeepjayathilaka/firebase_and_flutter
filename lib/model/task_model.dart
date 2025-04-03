import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  bool isUpdated;

  Task({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.isUpdated,
  });

  //Method to convert the firebase document in to a dart object
  factory Task.fromJson(Map<String, dynamic> doc, String id) {
    return Task(
      id: id,
      name: doc['name'],
      createdAt: (doc['createdAt'] as Timestamp).toDate(),
      updatedAt: (doc['updatedAt'] as Timestamp).toDate(),
      isUpdated: doc['isCompleted'],
    );
  }

  //Method to convert the dart object in to a firebase document
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'isCompleted': isUpdated,
    };
  }
}

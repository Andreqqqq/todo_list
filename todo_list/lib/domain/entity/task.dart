// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_flutter/hive_flutter.dart';

part 'task.g.dart';

@HiveType(typeId: 2)
class Task extends HiveObject {
  @HiveField(0)
  String text;

  @HiveField(1)
  bool isDone;

  @HiveField(2)
  int priority;
  Task({
    required this.text,
    required this.isDone,
    this.priority = 0,
  });
}

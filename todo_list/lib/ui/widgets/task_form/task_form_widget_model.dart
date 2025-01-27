// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:todo_list/domain/data_provider/box_manager.dart';
import '../../../domain/entity/task.dart';

class TaskFormWidgetModel extends ChangeNotifier {
  int groupKey;
  var _taskText = '';
  bool get isValid => _taskText.trim().isNotEmpty;

  set taskText(String value) {
    final isTaskTextEmpty = _taskText.trim().isEmpty;
    _taskText = value;
    if (value.trim().isEmpty != isTaskTextEmpty) {
      notifyListeners();
    }
  }

  TaskFormWidgetModel({required this.groupKey});

  void saveTask(BuildContext context) async {
    final taskText = _taskText.trim();
    if (taskText.isEmpty) return;
    final task = Task(text: taskText, isDone: false);
    final box = await BoxManager.instance.openTasksBox(groupKey);
    await box.add(task);
    await BoxManager.instance.closeBox(box);
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }
}

class TaskFormWidgetModelProvider extends InheritedNotifier {
  const TaskFormWidgetModelProvider(
      {super.key, required this.model, required this.child})
      : super(child: child, notifier: model);

  @override
  // ignore: overridden_fields
  final Widget child;
  final TaskFormWidgetModel model;

  static TaskFormWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TaskFormWidgetModelProvider>();
  }

  static TaskFormWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TaskFormWidgetModelProvider>()
        ?.widget;
    return widget is TaskFormWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(TaskFormWidgetModelProvider oldWidget) {
    return false;
  }
}

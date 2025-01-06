// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_list/ui/widgets/tasks/tasks_widget_model.dart';

class TasksWidgetConfiguration {
  final int groupKey;
  final String title;

  TasksWidgetConfiguration({required this.groupKey, required this.title});
}

class TasksWidget extends StatefulWidget {
  final TasksWidgetConfiguration configuration;

  const TasksWidget({
    super.key,
    required this.configuration,
  });

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  late final TasksWidgetModel _model;

  @override
  void initState() {
    super.initState();
    _model = TasksWidgetModel(configuration: widget.configuration);
  }

  @override
  void dispose() async {
    await _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TasksWidgetModelProvider(model: _model, child: _TasksWidgetBody());
  }
}

class _TasksWidgetBody extends StatelessWidget {
  const _TasksWidgetBody();

  @override
  Widget build(BuildContext context) {
    final model = TasksWidgetModelProvider.watch(context)?.model;
    final title = model?.configuration.title ?? 'Завдання';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const SafeArea(child: _TaskListWidget()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => model?.navForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _TaskListWidget extends StatelessWidget {
  const _TaskListWidget();

  @override
  Widget build(BuildContext context) {
    final tasksCount =
        TasksWidgetModelProvider.watch(context)?.model.tasks.length ?? 0;

    return ListView.separated(
      itemCount: tasksCount,
      itemBuilder: (BuildContext context, int index) {
        return _TaskListRowWidget(
          indexInList: index,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 0,
        );
      },
    );
  }
}

class _TaskListRowWidget extends StatelessWidget {
  final int indexInList;
  const _TaskListRowWidget({
    required this.indexInList,
  });

  @override
  Widget build(BuildContext context) {
    final model = TasksWidgetModelProvider.read(context)!.model;
    final task = model.tasks[indexInList];
    final style =
        task.isDone ? TextStyle(decoration: TextDecoration.lineThrough) : null;
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.4,
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            label: 'Change',
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icons.drive_file_rename_outline,
            onPressed: (context) => model.navForm(context),
          ),
          SlidableAction(
            label: 'Delete',
            backgroundColor: Colors.red,
            icon: Icons.delete,
            onPressed: (context) => model.deleteTask(indexInList),
          ),
        ],
      ),
      // В _TaskListRowWidget змінимо логіку чекбокса
      child: ListTile(
        title: Text(
          task.text,
          style: style,
        ),
        trailing: Checkbox(
          // Прибрали IgnorePointer
          value: task.isDone,
          onChanged: (bool? value) => model.toggleDone(indexInList),
        ),
        onTap: () => model.toggleDone(indexInList),
      ),
    );
  }
}

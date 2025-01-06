import 'package:flutter/material.dart';
import 'package:todo_list/ui/widgets/task_form/task_form_widget_model.dart';

class TaskFormWidgetConfiguration {
  final int groupKey;
  final String text;

  TaskFormWidgetConfiguration({required this.groupKey, required this.text});
}

class TaskFormWidget extends StatefulWidget {
  final int groupKey;
  const TaskFormWidget({super.key, required this.groupKey});

  @override
  State<TaskFormWidget> createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  late final TaskFormWidgetModel _model;
  @override
  void initState() {
    super.initState();
    _model = TaskFormWidgetModel(groupKey: widget.groupKey);
  }

  @override
  Widget build(BuildContext context) {
    return TaskFormWidgetModelProvider(
        model: _model, child: _TextFormWidgetBody());
  }
}

class _TextFormWidgetBody extends StatelessWidget {
  const _TextFormWidgetBody();

  @override
  Widget build(BuildContext context) {
    final model = TaskFormWidgetModelProvider.watch(context)?.model;
    final actionButton = FloatingActionButton.extended(
      onPressed: () =>
          TaskFormWidgetModelProvider.read(context)?.model.saveTask(context),
      label: const Text(
        'Зберегти',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      icon: const Icon(Icons.done_sharp),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Нова задача'),
      ),
      body: Center(
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: _TaskTextWidget(),
        ),
      ),
      floatingActionButton: model?.isValid == true ? actionButton : null,
    );
  }
}

class _TaskTextWidget extends StatelessWidget {
  const _TaskTextWidget();

  @override
  Widget build(BuildContext context) {
    final model = TaskFormWidgetModelProvider.read(context)?.model;
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      autofocus: true,
      maxLines: null,
      minLines: null,
      expands: true,
      decoration: const InputDecoration(
          hintText: 'Назва задачі', border: InputBorder.none),
      onEditingComplete: () => model?.saveTask(context),
      onChanged: (value) => model?.taskText = value,
    );
  }
}

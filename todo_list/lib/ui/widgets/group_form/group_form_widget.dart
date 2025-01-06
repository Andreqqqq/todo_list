import 'package:flutter/material.dart';
import 'package:todo_list/ui/widgets/group_form/group_form_widget_model.dart';

class GroupFormWidget extends StatefulWidget {
  const GroupFormWidget({super.key});

  @override
  State<GroupFormWidget> createState() => _GroupFormWidgetState();
}

class _GroupFormWidgetState extends State<GroupFormWidget> {
  final _model = GroupFormWidgetModel();
  @override
  Widget build(BuildContext context) {
    return GroupFormWidgetModelProvider(
      model: _model,
      child: const _GroupFormWidgetBody(),
    );
  }
}

class _GroupFormWidgetBody extends StatelessWidget {
  const _GroupFormWidgetBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Нова група'),
      ),
      body: Center(
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: _GroupNameWidget(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => GroupFormWidgetModelProvider.read(context)
            ?.model
            .saveGroup(context),
        label: const Text(
          'Зберегти',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        icon: const Icon(Icons.done_sharp),
      ),
    );
  }
}

class _GroupNameWidget extends StatelessWidget {
  const _GroupNameWidget();

  @override
  Widget build(BuildContext context) {
    final model = GroupFormWidgetModelProvider.watch(context)?.model;
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      autofocus: true,
      decoration:
          InputDecoration(hintText: 'Назва групи', errorText: model?.errorText),
      onEditingComplete: () => model?.saveGroup(context),
      onChanged: (value) => model?.groupName = value,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';

class SampleGroupWidget extends ConsumerStatefulWidget {
  const SampleGroupWidget({super.key});

  @override
  ConsumerState<SampleGroupWidget> createState() => _SampleGroupWidgetState();
}

class _SampleGroupWidgetState extends ConsumerState<SampleGroupWidget> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final ruleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('group widget')),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateGroupSampleView(),
                    ),
                  );
                },
                child: const Text("create"),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const JoinGroupSampleView(),
                    ),
                  );
                },
                child: const Text("join"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateGroupSampleView extends ConsumerStatefulWidget {
  const CreateGroupSampleView({super.key});

  @override
  ConsumerState<CreateGroupSampleView> createState() =>
      CreateGroupSampleViewState();
}

class CreateGroupSampleViewState extends ConsumerState<CreateGroupSampleView> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final ruleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('group widget')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Column(children: [
              TextField(
                controller: titleController,
              ),
              TextField(
                controller: descriptionController,
              ),
              TextField(
                controller: ruleController,
              ),
            ])),
            ElevatedButton(
                onPressed: () async {
                  final groupEntity =
                      await ref.read(createGroupUsecaseProvider)((
                    titleController.text,
                    descriptionController.text,
                    ruleController.text
                  ));
                  print(groupEntity);
                },
                child: Text("create")),
          ],
        ),
      ),
    );
  }
}

class JoinGroupSampleView extends ConsumerStatefulWidget {
  const JoinGroupSampleView({super.key});

  @override
  ConsumerState<JoinGroupSampleView> createState() =>
      _JoinGroupSampleViewState();
}

class _JoinGroupSampleViewState extends ConsumerState<JoinGroupSampleView> {
  final groupIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('join')),
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            TextField(
              controller: groupIdController,
            ),
            ElevatedButton(
                onPressed: () {
                  final groupId = groupIdController.text;
                  ref.read(applyForJoiningGroupUsecaseProvider)(groupId);
                },
                child: Text("Join"))
          ],
        ),
      )),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/utils/firebase_collection_name.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/domain.dart';
import 'package:wehavit/domain/entities/entities.dart';

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
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AcceptGroupSampleView(),
                    ),
                  );
                },
                child: const Text("accept"),
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

class AcceptGroupSampleView extends ConsumerStatefulWidget {
  const AcceptGroupSampleView({super.key});

  @override
  ConsumerState<AcceptGroupSampleView> createState() =>
      _AcceptGroupSampleViewState();
}

class _AcceptGroupSampleViewState extends ConsumerState<AcceptGroupSampleView> {
  final groupIdController = TextEditingController();
  List<UserDataEntity> applyList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Accept')),
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            TextField(
              controller: groupIdController,
            ),
            ElevatedButton(
                onPressed: () async {
                  final groupId = groupIdController.text;
                  final model = (await FirebaseFirestore.instance
                          .collection(FirebaseCollectionName.groups)
                          .doc(groupId)
                          .get())
                      .data()!
                    ..addAll({'groupId': groupId});
                  final groupEntity = GroupEntity.fromJson(model);
                  print(groupEntity);

                  final acceptList = (await FirebaseFirestore.instance
                          .collection(FirebaseCollectionName
                              .getGroupApplyWaitingCollectionName(groupId))
                          .get())
                      .docs
                      .map((doc) => doc['uid'] as String)
                      .toList();
                  print(acceptList);

                  final userList = await Future.wait(
                    acceptList.map((uid) async {
                      final entity = (await ref
                              .read(fetchUserDataFromIdUsecaseProvider)(uid))
                          .fold((l) => null, (entity) => entity);

                      if (entity != null) {
                        return entity;
                      }
                    }),
                  );

                  setState(() {
                    applyList = userList.whereType<UserDataEntity>().toList();
                  });
                },
                child: Text("Join")),
            Column(
              children: applyList
                  .map(
                    (e) => Row(
                      children: [
                        Text(e.userName!),
                        Spacer(),
                        ElevatedButton(
                            onPressed: () {
                              ref.read(
                                  acceptApplyingForJoiningGroupUsecaseProvider)((
                                groupIdController.text,
                                e.userId!,
                              ));

                              applyList.remove(e);
                              setState(() {});
                            },
                            child: Text("Accept")),
                        ElevatedButton(
                            onPressed: () {
                              ref.read(
                                  rejectApplyingForJoiningGroupUsecaseProvider)((
                                groupIdController.text,
                                e.userId!,
                              ));
                              applyList.remove(e);
                              setState(() {});
                            },
                            child: Text("Reject")),
                      ],
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      )),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/constants/constants.dart';
import 'package:wehavit/common/utils/firebase_collection_name.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';
import 'package:wehavit/presentation/group/group.dart';

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
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WithdrawalGroupSampleView(),
                    ),
                  );
                },
                child: const Text("withdrawal"),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AnnouncementGroupSampleView(),
                    ),
                  );
                },
                child: const Text("announcement"),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CellWidgetGroupSampleView(),
                    ),
                  );
                },
                child: const Text("check group list"),
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
                      await ref.read(createGroupUsecaseProvider)(
                    groupName: titleController.text,
                    groupDescription: descriptionController.text,
                    groupRule: ruleController.text,
                    groupColor: 0,
                  );
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

class WithdrawalGroupSampleView extends ConsumerStatefulWidget {
  const WithdrawalGroupSampleView({super.key});

  @override
  ConsumerState<WithdrawalGroupSampleView> createState() =>
      _WithdrawalGroupSampleViewState();
}

class _WithdrawalGroupSampleViewState
    extends ConsumerState<WithdrawalGroupSampleView> {
  final groupIdController = TextEditingController();
  List<UserDataEntity> applyList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('withdrawal')),
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
                  ref.read(withdrawalFromGroupUsecaseProvider)(groupId);
                },
                child: const Text('withdrawal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnnouncementGroupSampleView extends ConsumerStatefulWidget {
  const AnnouncementGroupSampleView({super.key});

  @override
  ConsumerState<AnnouncementGroupSampleView> createState() =>
      _AnnouncementGroupSampleViewState();
}

class _AnnouncementGroupSampleViewState
    extends ConsumerState<AnnouncementGroupSampleView> {
  final groupIdController = TextEditingController();
  List<GroupAnnouncementEntity> groupAnnouncmenetList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('announcement')),
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
                  ref.read(uploadGroupAnnouncementUsecaseProvider)(
                    groupId: groupId,
                    title: 'group announcement title',
                    content: 'group announcement content',
                  );
                },
                child: const Text('announce'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final groupId = groupIdController.text;
                  groupAnnouncmenetList = await ref
                      .read(getGroupAnnouncementListUsecaseProvider)
                      (groupId: groupId)
                      .then((result) => result.fold((l) => [], (r) => r));
                  setState(() {});
                },
                child: const Text('read'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final groupId = groupIdController.text;
                  final report = await ref
                      .read(getGroupWeeklyReportUsecaseProvider)
                      .call(groupId: groupId)
                      .then((value) =>
                          value.fold((l) => null, (report) => report));
                  print(report);
                },
                child: const Text('report'),
              ),
              Divider(),
              Column(
                children: groupAnnouncmenetList
                    .map(
                      (entity) => ElevatedButton(
                        child: Container(
                          child: Text(entity.title),
                        ),
                        onPressed: () async {
                          ref.read(readGroupAnnouncementUsecaseProvider)(
                            entity: entity,
                          );
                        },
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CellWidgetGroupSampleView extends ConsumerStatefulWidget {
  const CellWidgetGroupSampleView({super.key});

  @override
  ConsumerState<CellWidgetGroupSampleView> createState() =>
      _CellWidgetGroupSampleViewState();
}

class _CellWidgetGroupSampleViewState
    extends ConsumerState<CellWidgetGroupSampleView> {
  final groupIdController = TextEditingController();

  List<Widget> groupListViewCellList = [
    GroupListViewCellWidget(
      cellModel: GroupListViewCellWidgetModel.dummyModel,
    ),
    GroupListViewCellWidget(
      cellModel: GroupListViewCellWidgetModel.dummyModel,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whDarkBlack,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          '참여중인 그룹 목록',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: false,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: groupIdController,
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      final groupModel = await ref
                          .watch(getGroupListViewCellWidgetModelUsecaseProvider)
                          .call(
                            groupEntity: GroupEntity(
                              groupName: 'test',
                              groupManagerUid: '',
                              groupMemberUidList: [],
                              groupCreatedAt: DateTime.now(),
                              groupColor: 0,
                              groupId: groupIdController.text,
                            ),
                          )
                          .then(
                            (value) => value.fold(
                              (failure) => null,
                              (model) => model,
                            ),
                          );

                      if (groupModel != null) {
                        setState(() {
                          groupListViewCellList = List<Widget>.generate(
                            1,
                            (index) => GroupListViewCellWidget(
                              cellModel: groupModel,
                            ),
                          );
                        });
                      }
                    },
                    child: Text('enter')),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: groupListViewCellList.length + 1,
                itemBuilder: (context, index) {
                  if (index < groupListViewCellList.length) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: 12,
                      ),
                      child: groupListViewCellList[index],
                    );
                  } else {
                    return GroupListViewAddCellWidget(
                      tapAddGroupCallback: () async {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return GradientBottomSheet(
                              Column(
                                children: [
                                  ColoredButton(
                                    buttonTitle: '기존 그룹에 참여하기',
                                    buttonIcon: Icons.search,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          fullscreenDialog: true,
                                          builder: (context) {
                                            return const JoinGroupView();
                                          },
                                        ),
                                      ).then((_) => Navigator.pop(context));
                                    },
                                    // isDiminished: true,
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  ColoredButton(
                                    buttonTitle: '새로운 그룹 만들기',
                                    buttonIcon: Icons.flag_outlined,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          fullscreenDialog: true,
                                          builder: (context) {
                                            return CreateGroupView();
                                          },
                                        ),
                                      ).then((_) => Navigator.pop(context));
                                    },
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  ColoredButton(
                                    buttonTitle: '돌아가기',
                                    onPressed: () {},
                                    isDiminished: true,
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

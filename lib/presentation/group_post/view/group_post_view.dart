// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';
import 'dart:math';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/group_post/provider/send_reaction_state_model_provider.dart';
import 'package:wehavit/presentation/presentation.dart';
import 'package:wehavit/presentation/state/group_post/confirm_post_provider.dart';

// ignore: must_be_immutable
class GroupPostView extends ConsumerStatefulWidget {
  GroupPostView({super.key, required this.groupEntity});

  GroupEntity groupEntity;

  @override
  ConsumerState<GroupPostView> createState() => _GroupPostViewState();
}

class _GroupPostViewState extends ConsumerState<GroupPostView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final isGuideShown = await SharedPreferences.getInstance().then((instance) {
        return instance.getBool(PreferenceKey.isReactionGuideShown);
      });

      if (isGuideShown == null || isGuideShown == false) {
        showModalBottomSheet(
          isScrollControlled: true,
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => GradientBottomSheet(
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.80,
              child: const ReactionGuideView(),
            ),
          ),
        ).whenComplete(() {
          SharedPreferences.getInstance().then((instance) {
            instance.setBool(PreferenceKey.isReactionGuideShown, true);
          });
        });
      }
    });
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    final viewModel = ref.watch(groupPostViewModelProvider);
    final provider = ref.read(groupPostViewModelProvider.notifier);
    viewModel.groupId = widget.groupEntity.groupId;

    unawaited(
      provider.loadAppliedUserCount(entity: widget.groupEntity).whenComplete(() {
        setState(() {});
      }),
    );

    unawaited(
      provider
          .loadConfirmPostsForWeek(
            mondayOfTargetWeek: viewModel.calendartMondayDateList[0],
          )
          .whenComplete(() => setState(() {})),
    );

    unawaited(
      provider
          .loadConfirmPostsForWeek(
            mondayOfTargetWeek: viewModel.calendartMondayDateList[1],
          )
          .whenComplete(() => setState(() {})),
    );

    unawaited(provider.loadConfirmPostEntityListFor(dateTime: DateTime.now()));
  }

  DateTime selectedDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  bool isCommentMode = false;

  final commentFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(groupPostViewModelProvider);
    final provider = ref.read(groupPostViewModelProvider.notifier);

    return PopScope(
      onPopInvokedWithResult: (_, __) {
        ref.invalidate(confirmPostListProvider);
      },
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: CustomColors.whGrey200,
            resizeToAvoidBottomInset: true,
            appBar: WehavitAppBar(
              titleLabel: widget.groupEntity.groupName,
              leadingIconString: WHIcons.back,
              leadingAction: () {
                Navigator.pop(context);
              },
              trailingIconString: WHIcons.friend,
              trailingAction: () async {
                // TODO? TrailingAction 수정 필요
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return GroupMemberListBottomSheet(
                      // updateGroupEntity,
                      groupEntity: widget.groupEntity,
                    );
                  },
                ).whenComplete(() async {
                  await provider.loadAppliedUserCount(
                    entity: widget.groupEntity,
                  );
                  setState(() {});
                });
              },
              trailingIconBadgeCount: viewModel.appliedUserCountForManager,
            ),
            body: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      SafeArea(
                        minimum: const EdgeInsets.symmetric(horizontal: 16.0),
                        bottom: false,
                        child: Column(
                          children: [
                            WeeklyPostSwipeCalendar(
                              groupId: widget.groupEntity.groupId,
                              firstDate: widget.groupEntity.groupCreatedAt,
                              onSelected: (selectedDate) {
                                setState(() {
                                  this.selectedDate = selectedDate;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            Expanded(
                              child: Consumer(
                                builder: (context, ref, child) {
                                  final asyncEntityList = ref.watch(
                                    confirmPostListProvider(
                                      GroupConfirmPostProviderParam(widget.groupEntity.groupId, selectedDate),
                                    ),
                                  );

                                  return asyncEntityList.when(
                                    data: (entityList) {
                                      return Visibility(
                                        visible: entityList.isNotEmpty,
                                        replacement: const NoPostPlaceholder(),
                                        child: SingleChildScrollView(
                                          padding: const EdgeInsets.only(bottom: 20.0),
                                          // physics: reactionCameraViewModel.nonScrollMode
                                          //     ? const NeverScrollableScrollPhysics()
                                          //     : const AlwaysScrollableScrollPhysics(),
                                          child: Column(
                                            children: List<Widget>.generate(
                                              entityList.length,
                                              (index) => Padding(
                                                padding: const EdgeInsets.only(bottom: 12.0),
                                                // child: ConfirmPostWidget(
                                                //   confirmPostEntity: entityList[index],
                                                //   createdDate: viewModel.selectedDate,
                                                // ),
                                                child: ConfirmPostListCell(
                                                  confirmPostEntity: entityList[index],
                                                  onSendCommentPressed: () {
                                                    setState(() {
                                                      isCommentMode = true;
                                                    });
                                                  },
                                                  onEmojiPressed: () async {
                                                    await showEmojiSheet(entityList[index], context).whenComplete(
                                                      () {
                                                        if (ref
                                                                .read(
                                                                  sendReactionStateModelNotifierProvider(
                                                                    entityList[index],
                                                                  ),
                                                                )
                                                                .emojiSendCount ==
                                                            0) {
                                                          return null;
                                                        }

                                                        ref
                                                            .read(
                                                              sendReactionStateModelNotifierProvider(
                                                                entityList[index],
                                                              ),
                                                            )
                                                            .emojiWidgets
                                                            .clear();

                                                        return ref
                                                            .read(
                                                              sendReactionStateModelNotifierProvider(
                                                                entityList[index],
                                                              ).notifier,
                                                            )
                                                            .sendReaction()
                                                            .then((result) {
                                                          final resultMessage = result.fold(
                                                            (_) => '잠시 후 다시 시도해주세요',
                                                            (_) => '친구에게 이모지로 응원을 보냈어요',
                                                          );

                                                          if (context.mounted) {
                                                            showToastMessage(
                                                              context,
                                                              text: resultMessage,
                                                            );
                                                          }
                                                        });
                                                      },
                                                    );

                                                    ref.invalidate(sendReactionStateModelNotifierProvider);
                                                  },
                                                  onQuickshotTapUp: (_) {},
                                                  onQuickshotLongPressStart: (_) {},
                                                  onQuickshotLongPressMove: (_) {},
                                                  onQuickshotLongPressEnd: (_) {},
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    error: (_, __) {
                                      return const NoPostPlaceholder();
                                    },
                                    loading: () {
                                      return const Center(
                                        child: SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: CircularProgressIndicator(
                                            color: CustomColors.whGrey700,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isCommentMode)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isCommentMode = false;
                              commentFocusNode.unfocus();
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  CustomColors.whGrey100.withOpacity(0.6),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                if (isCommentMode)
                  ReactionCommentBottomToolbar(commentFocusNode: commentFocusNode, onActionPressed: () {}),
              ],
            ),
          ),
          ValueListenableBuilder(
            valueListenable: reactionCameraWidgetModeNotifier,
            builder: (context, value, child) {
              if (value != ReactionCameraWidgetMode.none) {
                return const ReactionCameraWidget();
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }

  Future<dynamic> showEmojiSheet(
    ConfirmPostEntity postEntity,
    BuildContext context,
  ) {
    void disposeWidget(UniqueKey key) {
      if (mounted) {
        ref.read(sendReactionStateModelNotifierProvider(postEntity)).emojiWidgets.remove(key);
      }
    }

    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.none,
      elevation: 0,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      clipBehavior: Clip.none,
                      children:
                          ref.watch(sendReactionStateModelNotifierProvider(postEntity)).emojiWidgets.values.toList(),
                    );
                  },
                ),
                GradientBottomSheet(
                  Consumer(
                    builder: (context, ref, child) {
                      final sendReactionState = ref.watch(sendReactionStateModelNotifierProvider(postEntity));
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.bottomCenter,
                                margin: const EdgeInsets.only(bottom: 16),
                                height: 70,
                                child: Text(
                                  sendReactionState.emojiSendCount.toString(),
                                  style: TextStyle(
                                    fontSize: 40 + 24 * min(1, sendReactionState.emojiSendCount / 24),
                                    color: Color.lerp(
                                      CustomColors.whYellow500,
                                      CustomColors.whRed500,
                                      min(1, sendReactionState.emojiSendCount / 24),
                                    ),
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                              Text(
                                '반응을 보내주세요!',
                                style: context.titleMedium?.copyWith(
                                  color: CustomColors.whYellow500,
                                ),
                              ),
                              const SizedBox(height: 36.0),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Column(
                              children: List<Widget>.generate(
                                3,
                                (index) => Row(
                                  children: List<Widget>.generate(5, (jndex) {
                                    final key = UniqueKey();
                                    return Expanded(
                                      key: key,
                                      child: GestureDetector(
                                        onTapUp: (detail) {
                                          final emojiIndex = index * 5 + jndex;
                                          setState(() {
                                            ref
                                                .read(sendReactionStateModelNotifierProvider(postEntity).notifier)
                                                .addEmoji(emojiIndex);
                                          });

                                          shootEmoji(emojiIndex, postEntity, context, disposeWidget);
                                        },
                                        child: Image(image: AssetImage(Emojis.emojiList[index * 5 + jndex])),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void shootEmoji(
    int emojiIndex,
    ConfirmPostEntity postEntity,
    BuildContext context,
    void Function(UniqueKey key) disposeWidget,
  ) {
    final animationWidgetKey = UniqueKey();
    ref.read(sendReactionStateModelNotifierProvider(postEntity)).emojiWidgets.addEntries(
          {
            animationWidgetKey: ShootEmojiWidget(
              key: animationWidgetKey,
              emojiIndex: emojiIndex,
              currentPos: Point(MediaQuery.of(context).size.width * Random().nextDouble(), 0),
              targetPos: Point(
                MediaQuery.of(context).size.width / 2,
                MediaQuery.of(context).size.height - 500 + 200,
              ),
              disposeWidgetFromParent: disposeWidget,
            ),
          }.entries,
        );
  }
}

class NoPostPlaceholder extends StatelessWidget {
  const NoPostPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '아무도 인증글을 남기지 않은\n조용한 날이네요',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: CustomColors.whWhite,
            ),
          ),
          Text(
            '🤫',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: CustomColors.whWhite,
            ),
          ),
          SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }
}

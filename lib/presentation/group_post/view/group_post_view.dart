// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';
import 'dart:math';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/group_post/provider/send_reaction_state_model_provider.dart';
import 'package:wehavit/presentation/presentation.dart';
import 'package:wehavit/presentation/state/group_post/confirm_post_provider.dart';
import 'package:wehavit/presentation/state/group_post/friend_post_provider.dart';
import 'package:wehavit/presentation/state/reaction/quickshot_preset_provider.dart';
import 'package:wehavit/presentation/state/user_data/my_user_data_provider.dart';

// ignore: must_be_immutable
class GroupPostView extends ConsumerStatefulWidget {
  GroupPostView({super.key, required this.groupEntity});

  /// GroupEntity가 null인 경우에 '내 친구들' 페이지가 보여짐
  GroupEntity? groupEntity;

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

  DateTime selectedDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  bool isCommentMode = false;

  final commentFocusNode = FocusNode();
  final reactionCommentTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(groupPostViewModelProvider);

    return PopScope(
      onPopInvokedWithResult: (_, __) async {
        refreshPostList();
      },
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: CustomColors.whGrey200,
            resizeToAvoidBottomInset: true,
            appBar: WehavitAppBar(
              titleLabel: widget.groupEntity?.groupName ?? '내 친구들',
              leadingIconString: WHIcons.back,
              leadingAction: () {
                Navigator.pop(context);
              },
              trailingIconString: widget.groupEntity != null ? WHIcons.friend : '',

              trailingAction: () async {
                if (widget.groupEntity != null) {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return GroupMemberListBottomSheet(groupId: widget.groupEntity!.groupId);
                    },
                  );
                }
              },
              // trailingIconBadgeCount: viewModel.appliedUserCountForManager,
            ),
            body: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      SafeArea(
                        minimum: const EdgeInsets.symmetric(horizontal: 16.0),
                        bottom: false,
                        child: Consumer(
                          builder: (context, ref, child) {
                            final asyncResolutionList = widget.groupEntity != null
                                ? ref.watch(
                                    groupSharedResolutionListProvider(
                                      GroupSharedResolutionProviderParam(
                                        widget.groupEntity!.groupId,
                                        widget.groupEntity!.groupMemberUidList,
                                      ),
                                    ),
                                  )
                                : ref.watch(friendSharedResolutionListProvider);

                            return asyncResolutionList.when(
                              data: (resolutionList) {
                                return Column(
                                  children: [
                                    WeeklyPostSwipeCalendar(
                                      resolutionList: resolutionList,
                                      firstDate: widget.groupEntity?.groupCreatedAt ??
                                          ref.watch(getMyUserDataProvider).value!.createdAt,
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
                                          final asyncEntityList = widget.groupEntity != null
                                              ? ref.watch(
                                                  confirmPostListProvider(
                                                    ConfirmPostProviderParam(resolutionList, selectedDate),
                                                  ),
                                                )
                                              : ref.watch(friendPostListProvider(selectedDate));

                                          return asyncEntityList.when(
                                            data: (entityList) {
                                              return Visibility(
                                                visible: entityList.isNotEmpty,
                                                replacement: const NoPostPlaceholder(),
                                                child: RefreshIndicator(
                                                  onRefresh: () async {
                                                    refreshPostList(targetDate: selectedDate);
                                                  },
                                                  child: ListView.builder(
                                                    padding: const EdgeInsets.only(bottom: 20.0),
                                                    itemCount: entityList.length,
                                                    itemBuilder: (context, index) {
                                                      return Padding(
                                                        padding: const EdgeInsets.only(bottom: 12.0),
                                                        child: ConfirmPostListCell(
                                                          confirmPostEntity: entityList[index],
                                                          onSendCommentPressed: () {
                                                            viewModel.commentTargetEntity = entityList[index];
                                                            setState(() {
                                                              isCommentMode = true;
                                                            });
                                                            commentFocusNode.requestFocus();
                                                          },
                                                          onEmojiPressed: () async {
                                                            await showEmojiSheet(entityList[index], context)
                                                                .whenComplete(() {
                                                              if (ref
                                                                      .read(
                                                                        sendReactionStateModelNotifierProvider(
                                                                          entityList[index],
                                                                        ),
                                                                      )
                                                                      .emojiSendCount ==
                                                                  0) {
                                                                return;
                                                              }

                                                              ref
                                                                  .read(
                                                                    sendReactionStateModelNotifierProvider(
                                                                      entityList[index],
                                                                    ),
                                                                  )
                                                                  .emojiWidgets
                                                                  .clear();

                                                              ref
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
                                                                  showToastMessage(context, text: resultMessage);
                                                                }
                                                              });
                                                            });

                                                            ref.invalidate(sendReactionStateModelNotifierProvider);
                                                          },
                                                          onQuickshotLongPressStart: (_) async {
                                                            PermissionStatus permission =
                                                                await Permission.camera.status;

                                                            if (permission == PermissionStatus.denied) {
                                                              await Permission.camera.request();
                                                            }
                                                            if (permission == PermissionStatus.granted) {
                                                              reactionCameraWidgetModeNotifier.value =
                                                                  ReactionCameraWidgetMode.quickshot;
                                                            }
                                                          },
                                                          onQuickshotLongPressMove: (detail) {
                                                            cameraPointerPositionNotifier.value = detail.globalPosition;
                                                          },
                                                          onQuickshotLongPressEnd: (detail) async {
                                                            final needCapture =
                                                                cameraPointerPositionNotifier.isPosInCapturingArea;

                                                            if (needCapture) {
                                                              final imageFilePath = await ref
                                                                  .read(reactionCameraWidgetModelProvider.notifier)
                                                                  .endOnCapturingArea();

                                                              ref
                                                                  .watch(
                                                                    sendReactionStateModelNotifierProvider(
                                                                      entityList[index],
                                                                    ),
                                                                  )
                                                                  .sendingQuickshotUrl = imageFilePath;

                                                              ref
                                                                  .read(
                                                                    sendReactionStateModelNotifierProvider(
                                                                      entityList[index],
                                                                    ).notifier,
                                                                  )
                                                                  .sendReaction()
                                                                  .then((result) {
                                                                final resultMessage = result.fold(
                                                                  (_) => '잠시 후 다시 시도해주세요',
                                                                  (_) => '친구에게 퀵샷으로 응원을 보냈어요',
                                                                );

                                                                if (context.mounted) {
                                                                  showToastMessage(context, text: resultMessage);
                                                                }

                                                                ref.invalidate(
                                                                  sendReactionStateModelNotifierProvider(
                                                                    entityList[index],
                                                                  ),
                                                                );
                                                              });
                                                            }
                                                            reactionCameraWidgetModeNotifier.value =
                                                                ReactionCameraWidgetMode.none;
                                                          },
                                                          onQuickshotPaletteCellTapUp: (imageFilePath) async {
                                                            ref
                                                                .watch(
                                                                  sendReactionStateModelNotifierProvider(
                                                                    entityList[index],
                                                                  ),
                                                                )
                                                                .sendingQuickshotUrl = imageFilePath;

                                                            ref
                                                                .read(
                                                                  sendReactionStateModelNotifierProvider(
                                                                    entityList[index],
                                                                  ).notifier,
                                                                )
                                                                .sendReaction()
                                                                .then((result) {
                                                              final resultMessage = result.fold(
                                                                (_) => '잠시 후 다시 시도해주세요',
                                                                (_) => '친구에게 퀵샷으로 응원을 보냈어요',
                                                              );

                                                              if (context.mounted) {
                                                                showToastMessage(context, text: resultMessage);
                                                              }
                                                            });

                                                            ref.invalidate(
                                                              sendReactionStateModelNotifierProvider(entityList[index]),
                                                            );
                                                          },
                                                          onQuickshotPaletteAddCellTapUp: () {
                                                            showToastMessage(context, text: '추가 버튼을 누른 채로 드래그 해주세요!');
                                                          },
                                                          onQuickshotPaletteAddCellLongPressStart: (detail) async {
                                                            PermissionStatus permission =
                                                                await Permission.camera.status;

                                                            if (permission == PermissionStatus.denied) {
                                                              await Permission.camera.request();
                                                            }
                                                            if (permission == PermissionStatus.granted) {
                                                              reactionCameraWidgetModeNotifier.value =
                                                                  ReactionCameraWidgetMode.preset;
                                                            }
                                                          },
                                                          onQuickshotPaletteAddCellLongPressMove: (detail) {
                                                            cameraPointerPositionNotifier.value = detail.globalPosition;
                                                          },
                                                          onQuickshotPaletteAddCellLongPressEnd: (detail) async {
                                                            final needCapture =
                                                                cameraPointerPositionNotifier.isPosInCapturingArea;

                                                            if (needCapture) {
                                                              final imageFilePath = await ref
                                                                  .read(reactionCameraWidgetModelProvider.notifier)
                                                                  .endOnCapturingArea();

                                                              ref
                                                                  .read(uploadQuickshotPresetUsecaseProvider)
                                                                  .call(localFileUrl: imageFilePath)
                                                                  .then((result) {
                                                                ref.invalidate(quickshotPresetProvider);
                                                              });
                                                            }
                                                            reactionCameraWidgetModeNotifier.value =
                                                                ReactionCameraWidgetMode.none;
                                                          },
                                                        ),
                                                      );
                                                    },
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
                                );
                              },
                              error: (_, __) {
                                return Container();
                              },
                              loading: () {
                                return Container();
                              },
                            );
                          },
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
                if (isCommentMode && viewModel.commentTargetEntity != null)
                  ReactionCommentBottomToolbar(
                    confirmPostEntity: viewModel.commentTargetEntity!,
                    controller: reactionCommentTextEditingController,
                    commentFocusNode: commentFocusNode,
                    onActionPressed: () async {
                      ref
                          .watch(
                            sendReactionStateModelNotifierProvider(
                              viewModel.commentTargetEntity!,
                            ),
                          )
                          .sendingComment = reactionCommentTextEditingController.text;

                      ref
                          .read(
                            sendReactionStateModelNotifierProvider(
                              viewModel.commentTargetEntity!,
                            ).notifier,
                          )
                          .sendReaction()
                          .then((result) {
                        final resultMessage = result.fold(
                          (_) => '잠시 후 다시 시도해주세요',
                          (_) => '친구에게 응원의 메시지를 보냈어요',
                        );

                        if (context.mounted) {
                          showToastMessage(
                            context,
                            text: resultMessage,
                          );
                        }

                        if (result.isRight()) {
                          reactionCommentTextEditingController.clear();
                          ref.invalidate(sendReactionStateModelNotifierProvider(viewModel.commentTargetEntity!));
                          setState(() {
                            isCommentMode = false;
                          });
                        }
                      });
                    },
                  ),
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

  Future<void> refreshPostList({DateTime? targetDate}) async {
    if (widget.groupEntity == null) {
      if (targetDate == null) {
        ref.invalidate(friendPostListProvider);
      } else {
        ref.invalidate(friendPostListProvider(targetDate));
      }
    } else {
      if (targetDate == null) {
        ref.invalidate(confirmPostListProvider);
      } else {
        ref.invalidate(confirmPostListProvider);
      }
    }
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

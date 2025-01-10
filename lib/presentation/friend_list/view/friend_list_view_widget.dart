import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';
import 'package:wehavit/presentation/friend_list/view/friend_list_view.dart';

enum FriendListCellState { normal, applied, managing, toApply }

class FriendListCellWidget extends ConsumerStatefulWidget {
  const FriendListCellWidget({
    super.key,
    required this.futureUserEntity,
    required this.cellState,
  });

  final EitherFuture<UserDataEntity> futureUserEntity;
  final FriendListCellState cellState;

  @override
  ConsumerState<FriendListCellWidget> createState() => _FriendListCellWidgetState();
}

class _FriendListCellWidgetState extends ConsumerState<FriendListCellWidget> {
  @override
  Widget build(BuildContext context) {
    return EitherFutureBuilder<UserDataEntity>(
      target: widget.futureUserEntity,
      forWaiting: Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: CustomColors.whBlack,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20,
                    width: 200,
                    decoration: BoxDecoration(
                      color: CustomColors.whBlack,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 20,
                    width: 90,
                    decoration: BoxDecoration(
                      color: CustomColors.whBlack,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
            // ColoredButton(buttonTitle: "Hi"),
          ],
        ),
      ),
      forFail: Container(),
      mainWidgetCallback: (userEntity) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 6.0),
          child: Row(
            children: [
              CircleProfileImage(
                size: 60,
                url: userEntity.userImageUrl,
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          userEntity.userName,
                          style: const TextStyle(
                            color: CustomColors.whWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Expanded(
                          child: Text(
                            ' • ${userEntity.handle}',
                            style: const TextStyle(
                              color: CustomColors.whSemiWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      userEntity.aboutMe,
                      style: const TextStyle(
                        color: CustomColors.whPlaceholderGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                ),
              ),
              postfixButtonWidget(userEntity, ref),
            ],
          ),
        );
      },
    );
  }

  Widget postfixButtonWidget(UserDataEntity entity, WidgetRef ref) {
    final provider = ref.read(friendListViewModelProvider.notifier);
    switch (widget.cellState) {
      case FriendListCellState.applied:
        return Row(
          children: [
            SmallColoredButton(
              buttonLabel: '수락',
              onPressed: () async {
                final parentState = context.findAncestorStateOfType<FrinedListViewState>();

                await provider.acceptToBeFriendWith(targetUid: entity.userId);

                if (mounted) {
                  parentState?.setState(() {});
                }
              },
            ),
            const SizedBox(
              width: 8,
            ),
            SmallColoredButton(
              buttonLabel: '거절',
              backgroundColor: CustomColors.whBrightGrey,
              onPressed: () async {
                final parentState = context.findAncestorStateOfType<FrinedListViewState>();

                await provider.rejectToBeFriendWith(
                  targetUid: entity.userId,
                );

                if (mounted) {
                  parentState?.setState(() {});
                }
              },
            ),
          ],
        );
      case FriendListCellState.managing:
        return SmallColoredButton(
          buttonLabel: '삭제',
          backgroundColor: CustomColors.whBrightGrey,
          onPressed: () async {
            final parentState = context.findAncestorStateOfType<FrinedListViewState>();

            await provider.removeFromFriendList(targetUid: entity.userId);

            if (mounted) {
              parentState?.setState(() {});
            }
          },
        );
      case FriendListCellState.toApply:
        return SmallColoredButton(
          buttonLabel: '요청',
          onPressed: () async {
            final parentState = context.findAncestorStateOfType<FrinedListViewState>();

            await provider.applyToBeFriendWith(targetUid: entity.userId).then((result) {
              if (result.isRight()) {
                showToastMessage(
                  context,
                  text: '친구 신청을 보냈어요',
                );
              }
            });

            if (mounted) {
              parentState?.setState(() {});
            }
          },
        );
      default:
        return Container();
    }
  }
}

class FriendListFailPlaceholderWidget extends StatelessWidget {
  const FriendListFailPlaceholderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '친구들에 대한 정보를\n불러오지 못했어요',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: CustomColors.whWhite,
            ),
          ),
          Text(
            '😭',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: CustomColors.whWhite,
            ),
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}

class FriendListTextFieldWidget extends StatelessWidget {
  const FriendListTextFieldWidget({
    super.key,
    required this.searchCallback,
  });

  final Function(String?) searchCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: CustomColors.whGrey,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                left: 8.0,
              ),
            ),
            Expanded(
              child: TextFormField(
                onFieldSubmitted: (value) {
                  searchCallback(value);
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  icon: Icon(Icons.search),
                  iconColor: CustomColors.whWhite,
                  hintText: 'ID로 친구 찾기',
                  hintStyle: TextStyle(
                    color: CustomColors.whWhite,
                    fontSize: 16,
                    height: 1.4,
                  ),
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: -8),
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  color: CustomColors.whWhite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///fdsa
class FriendListMyProfileWidget extends StatelessWidget {
  const FriendListMyProfileWidget({required this.futureUserEntity, super.key});

  final EitherFuture<UserDataEntity>? futureUserEntity;

  @override
  Widget build(BuildContext context) {
    return EitherFutureBuilder<UserDataEntity>(
      target: futureUserEntity,
      forWaiting: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: CustomColors.whBrightGrey,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 20,
                width: 200,
                decoration: BoxDecoration(
                  color: CustomColors.whBrightGrey,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                height: 20,
                width: 90,
                decoration: BoxDecoration(
                  color: CustomColors.whBrightGrey,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ],
      ),
      forFail: const SizedBox(
        width: double.infinity,
        child: Text(
          '정보를 가져오지 못했어요\n잠시 후 다시 시도해주세요',
          style: TextStyle(
            color: CustomColors.whWhite,
            fontSize: 16,
            height: 1.4,
          ),
        ),
      ),
      mainWidgetCallback: (userEntity) {
        return Row(
          children: [
            CircleProfileImage(
              url: userEntity.userImageUrl,
              size: 50,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userEntity.userName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: CustomColors.whWhite,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    userEntity.aboutMe,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: CustomColors.whWhite,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            // Column(
            //   children: [
            //     Image.asset(
            //       CustomIconImage.linkIcon,
            //       width: 20,
            //       height: 20,
            //     ),
            //     const SizedBox(
            //       height: 4,
            //     ),
            //     const Text(
            //       '복사하기',
            //       style: TextStyle(
            //         fontSize: 14.0,
            //         fontWeight: FontWeight.w700,
            //         color: CustomColors.whWhite,
            //       ),
            //     ),
            //   ],
            // ),
          ],
        );
      },
    );
  }
}

class FriendListPlaceholderWidget extends StatelessWidget {
  const FriendListPlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 30,
        ),
        Text(
          '친구들과 함께 도전하고 격려를 나눠보세요!\n우측 상단에서 친구 신청을 보낼 수 있어요',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: CustomColors.whWhite,
          ),
        ),
        Text(
          '😊 😊',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: CustomColors.whWhite,
          ),
        ),
      ],
    );
  }
}

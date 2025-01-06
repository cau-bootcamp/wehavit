import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/presentation.dart';

class MyPageWehavitSummaryWidget extends StatelessWidget {
  const MyPageWehavitSummaryWidget({
    super.key,
    required this.futureUserEntity,
  });

  final EitherFuture<UserDataEntity>? futureUserEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 150),
      decoration: const BoxDecoration(
        color: CustomColors.whSemiBlack,
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: 20.0,
            ),
            child: Column(
              children: [
                MyProfileWidget(futureUserEntity: futureUserEntity),
                const SizedBox(
                  height: 16,
                ),
                MySimpleStatisticsWidget(
                  futureUserEntity: futureUserEntity,
                ),
              ],
            ),
          ),
          const Divider(
            height: 2,
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: CustomColors.whYellow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: () {
              showToastMessage(
                context,
                text: '현재 개발중인 기능입니다!',
              );
            },
            child: const Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              // constraints: const BoxConstraints(minWidth: 250),
              children: [
                Text(
                  '더 많은 통계 보러가기',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: CustomColors.whWhite,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyProfileWidget extends StatelessWidget {
  const MyProfileWidget({required this.futureUserEntity, super.key});

  final EitherFuture<UserDataEntity>? futureUserEntity;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureUserEntity,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.all(12),
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: CustomColors.whYellow,
                ),
              ),
            ],
          );
        }

        if (snapshot.hasData && snapshot.data!.isRight()) {
          final userModel = snapshot.data!.getOrElse((l) => UserDataEntity.dummyModel);

          return Row(
            children: [
              CircleProfileImage(
                url: userModel.userImageUrl ?? '',
                size: 50,
              ),
              const SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userModel.userName ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: CustomColors.whWhite,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    userModel.aboutMe ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: CustomColors.whWhite,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          );
        }
        return Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: CustomColors.whBrightGrey,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 16.0),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '사용자 정보를 가져오지 못했어요',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: CustomColors.whWhite,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '잠시 후 다시 시도해주세요',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: CustomColors.whWhite,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class MySimpleStatisticsWidget extends StatelessWidget {
  const MySimpleStatisticsWidget({
    super.key,
    required this.futureUserEntity,
  });

  final EitherFuture<UserDataEntity>? futureUserEntity;

  @override
  Widget build(BuildContext context) {
    return EitherFutureBuilder<UserDataEntity>(
      target: futureUserEntity,
      forWaiting: LoadingAnimationWidget.waveDots(
        color: CustomColors.whBrightGrey,
        size: 30,
      ),
      forFail: const Text(
        '통계 정보를 가져오지 못했어요 😢',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: CustomColors.whWhite,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      mainWidgetCallback: (userEntity) {
        return IntrinsicHeight(
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.0),
                ),
                clipBehavior: Clip.hardEdge,
                child: const VerticalDivider(
                  thickness: 4,
                  width: 4,
                  color: CustomColors.whYellow,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SimpleStatisticsBulletWidget(
                      icon: '📆',
                      preText: '위해빗과 함께한 지 ',
                      highlightedText:
                          // ignore: lines_longer_than_80_chars
                          '${DateTime.now().difference(userEntity.createdAt ?? DateTime.now()).inDays + 1}일째',
                      postText: '가 되었어요.',
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SimpleStatisticsBulletWidget(
                      icon: '🕊️',
                      preText: '지금까지 ',
                      highlightedText: '${userEntity.cumulativeGoals}개',
                      postText: '의 목표에 도전했어요',
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SimpleStatisticsBulletWidget(
                      icon: '👀',
                      preText: '벌써 ',
                      highlightedText: '${userEntity.cumulativePosts}개',
                      postText: '의 실천을 인증했어요!',
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SimpleStatisticsBulletWidget(
                      icon: '👏',
                      preText: '그리고 ',
                      highlightedText: '${userEntity.cumulativeReactions}번',
                      postText: '이나 친구들을 응원했어요!',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SimpleStatisticsBulletWidget extends StatelessWidget {
  const SimpleStatisticsBulletWidget({
    super.key,
    required this.icon,
    required this.preText,
    required this.highlightedText,
    required this.postText,
  });

  final String icon;
  final String preText;
  final String highlightedText;
  final String postText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$icon ',
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        Text(
          preText,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: CustomColors.whWhite,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          highlightedText,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: CustomColors.whYellow,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          postText,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: CustomColors.whWhite,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class ResolutionListPlaceholderWidget extends StatelessWidget {
  const ResolutionListPlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 30,
        ),
        Text(
          '아직 도전중인 목표가 없으시네요!\n위해빗과 함께 새로운 도전을 시작해보세요',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: CustomColors.whWhite,
          ),
        ),
        Text(
          '😉',
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

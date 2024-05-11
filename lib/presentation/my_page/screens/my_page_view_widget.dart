import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/presentation.dart';

class MyPageWehavitSummaryWidget extends StatelessWidget {
  MyPageWehavitSummaryWidget({
    super.key,
  });

  final EitherFuture<UserDataEntity> dummyFutureUserEntity =
      Future.delayed(Duration(seconds: 2), () {
    return right(UserDataEntity.dummyModel);
    // return left(Failure("no data"));
  });

  final EitherFuture<(int, int, int, int)> dummyStatisticsTuple =
      Future.delayed(Duration(seconds: 2), () {
    return right((1, 2, 3, 4));
    // return left(Failure("no data"));
  });

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
                MyProfileWidget(futureUserEntity: dummyFutureUserEntity),
                const SizedBox(
                  height: 16,
                ),
                MySimpleStatisticsWidget(
                  futureStatisticsTuple: dummyStatisticsTuple,
                ),
              ],
            ),
          ),
          const Divider(
            height: 2,
          ),
          TextButton(
            onPressed: () {
              showToastMessage(
                context,
                text: '현재 개발중인 기능입니다!',
                icon: const Icon(
                  Icons.warning,
                  color: CustomColors.whYellow,
                ),
              );
            },
            child: const Text(
              '더 많은 통계 보러가기',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: CustomColors.whWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyProfileWidget extends StatelessWidget {
  const MyProfileWidget({required this.futureUserEntity, super.key});

  final EitherFuture<UserDataEntity> futureUserEntity;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureUserEntity,
      builder: (context, snapshot) {
        // waiting
        if (snapshot.connectionState == ConnectionState.waiting) {
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
          final userModel =
              snapshot.data!.getOrElse((l) => UserDataEntity.dummyModel);

          return Row(
            children: [
              ProfileImageCircleWidget(
                url: userModel.userImageUrl,
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
                    // TODO: UserEmail 대신 UserMessage 보여주기
                    userModel.userEmail ?? '',
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

class ProfileImageCircleWidget extends StatelessWidget {
  const ProfileImageCircleWidget({
    required this.size,
    required this.url,
    super.key,
  });

  final String? url;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      clipBehavior: Clip.hardEdge,
      child: Image.network(
        url ?? '',
        fit: BoxFit.cover,
      ),
    );
  }
}

class MySimpleStatisticsWidget extends StatelessWidget {
  const MySimpleStatisticsWidget({
    super.key,
    required this.futureStatisticsTuple,
  });

  final EitherFuture<(int, int, int, int)> futureStatisticsTuple;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureStatisticsTuple,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return RefreshProgressIndicator();
        }

        if (snapshot.hasData && snapshot.data!.isRight()) {
          return Row(
            children: [],
          );
        }
        return Row(
          children: [],
        );
      },
    );
    // return IntrinsicHeight(
    //   child: Row(
    //     children: [
    //       const VerticalDivider(
    //         thickness: 4,
    //         width: 16,
    //         color: CustomColors.whYellow,
    //       ),
    //       const SizedBox(width: 8),
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           SimpleStatisticsBulletWidget(
    //             icon: '📆',
    //             preText: '위해빗과 함께한 지 ',
    //             highlightedText: '${futureStatisticsTuple.$1}일째',
    //             postText: '가 되었어요.',
    //           ),
    //           const SizedBox(
    //             height: 8,
    //           ),
    //           SimpleStatisticsBulletWidget(
    //             icon: '🕊️',
    //             preText: '지금까지 ',
    //             highlightedText: '${futureStatisticsTuple.$2}개',
    //             postText: '의 목표에 도전했어요',
    //           ),
    //           const SizedBox(
    //             height: 8,
    //           ),
    //           SimpleStatisticsBulletWidget(
    //             icon: '👀',
    //             preText: '벌써 ',
    //             highlightedText: '${futureStatisticsTuple.$3}개',
    //             postText: '의 실천을 인증했어요!',
    //           ),
    //           const SizedBox(
    //             height: 8,
    //           ),
    //           SimpleStatisticsBulletWidget(
    //             icon: '👏',
    //             preText: '그리고 ',
    //             highlightedText: '${futureStatisticsTuple.$4}번',
    //             postText: '이나 친구들을 응원했어요!',
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
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

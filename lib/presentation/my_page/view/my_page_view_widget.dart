import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/presentation.dart';

class MyPageWehavitSummaryWidget extends StatelessWidget {
  MyPageWehavitSummaryWidget({
    super.key,
  });

  final EitherFuture<UserDataEntity> dummyFutureUserEntity =
      Future.delayed(Duration(seconds: 1), () {
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
                fontSize: 14.0,
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
    return EitherFutureBuilder<(int, int, int, int)>(
      target: futureStatisticsTuple,
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
      mainWidgetCallback: (statisticsTuple) {
        return IntrinsicHeight(
          child: Row(
            children: [
              const VerticalDivider(
                thickness: 4,
                width: 2,
                color: CustomColors.whYellow,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SimpleStatisticsBulletWidget(
                    icon: '📆',
                    preText: '위해빗과 함께한 지 ',
                    highlightedText: '${statisticsTuple.$1}일째',
                    postText: '가 되었어요.',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SimpleStatisticsBulletWidget(
                    icon: '🕊️',
                    preText: '지금까지 ',
                    highlightedText: '${statisticsTuple.$2}개',
                    postText: '의 목표에 도전했어요',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SimpleStatisticsBulletWidget(
                    icon: '👀',
                    preText: '벌써 ',
                    highlightedText: '${statisticsTuple.$3}개',
                    postText: '의 실천을 인증했어요!',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SimpleStatisticsBulletWidget(
                    icon: '👏',
                    preText: '그리고 ',
                    highlightedText: '${statisticsTuple.$4}번',
                    postText: '이나 친구들을 응원했어요!',
                  ),
                ],
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

class MyPageResolutionListCellWidget extends StatelessWidget {
  const MyPageResolutionListCellWidget({
    super.key,
    required this.resolutionEntity,
    required this.showDetails,
  });

  final ResolutionEntity resolutionEntity;
  final bool showDetails;

  @override
  Widget build(BuildContext context) {
    final EitherFuture<List<bool>> futureDoneList = Future.delayed(
        Duration(seconds: 2),
        () => right([
              true,
              true,
              false,
              false,
              true,
              true,
              false,
            ]));

    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      width: double.infinity,
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
              bottom: 20,
            ),
            child: Column(
              children: [
                ResolutionListCellHeadWidget(
                  goalStatement: resolutionEntity.goalStatement ?? '',
                  resolutionName: "resolution Name",
                  showGoalStatement: showDetails,
                ),
                const SizedBox(
                  height: 12,
                ),
                ResolutionLinearGaugeWidget(
                  resolutionEntity: resolutionEntity,
                  futureDoneCount:
                      Future.delayed(Duration(seconds: 3), () => right(3)),
                ),
                SizedBox(
                  height: showDetails ? 20 : 4,
                ),
                Visibility(
                  visible: showDetails,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${DateTime.now().difference(DateTime.now().subtract(Duration(days: 3))).inDays + 1}일째 도전 중',
                        style: const TextStyle(
                          color: CustomColors.whWhite,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      ResolutionListWeeklyDoneWidget(
                        futureDoneList: futureDoneList,
                        pointColor: PointColors.red,
                      )
                    ],
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

class ResolutionListCellHeadWidget extends StatelessWidget {
  const ResolutionListCellHeadWidget({
    super.key,
    required this.resolutionName,
    required this.goalStatement,
    required this.showGoalStatement,
  });

  final String resolutionName;
  final String goalStatement;
  final bool showGoalStatement;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: PointColors.red,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                resolutionName,
                style: const TextStyle(
                  color: PointColors.red,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
              Visibility(
                visible: showGoalStatement,
                child: Text(
                  goalStatement,
                  style: const TextStyle(
                    color: CustomColors.whWhite,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        const Icon(
          Icons.chevron_right,
          size: 32,
          color: PointColors.red,
        ),
      ],
    );
  }
}

class ResolutionListWeeklyDoneWidget extends StatelessWidget {
  const ResolutionListWeeklyDoneWidget({
    super.key,
    required this.futureDoneList,
    required this.pointColor,
  });

  final EitherFuture<List<bool>> futureDoneList;
  final Color pointColor;

  @override
  Widget build(BuildContext context) {
    return EitherFutureBuilder<List<bool>>(
      target: futureDoneList,
      forWaiting: Row(
        children: List<Widget>.generate(
          7,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: ResolutionListWeeklyDoneCellPlaceholderWidget(),
          ),
        ),
      ),
      forFail: Container(),
      mainWidgetCallback: (doneList) {
        return Row(
          children: List<Widget>.generate(
            7,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: ResolutionListWeeklyDoneCellWidget(
                isDone: doneList[index],
                weekday: index,
                pointColor: pointColor,
              ),
            ),
          ),
        );
      },
    );
  }
}

///
/// weekday는 월요일부터 0 ~ 일요일 6
class ResolutionListWeeklyDoneCellWidget extends StatelessWidget {
  const ResolutionListWeeklyDoneCellWidget({
    super.key,
    required this.isDone,
    required this.weekday,
    required this.pointColor,
  });

  final int weekday;
  final bool isDone;
  final Color pointColor;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isDone,
      replacement: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: CustomColors.whSemiBlack,
          border: Border.all(
            color: CustomColors.whBrightGrey,
            width: 2,
          ),
        ),
        width: 25,
        height: 25,
        alignment: Alignment.center,
        child: Text(
          weekdayKorean[weekday],
          style: const TextStyle(
            color: CustomColors.whBrightGrey,
            fontSize: 13.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: pointColor,
        ),
        alignment: Alignment.center,
        width: 25,
        height: 25,
        child: const Icon(
          Icons.check,
          color: CustomColors.whWhite,
          size: 22,
          weight: 100,
        ),
      ),
    );
  }
}

class ResolutionListWeeklyDoneCellPlaceholderWidget extends StatelessWidget {
  const ResolutionListWeeklyDoneCellPlaceholderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: CustomColors.whSemiBlack,
        border: Border.all(
          color: CustomColors.whBrightGrey,
          width: 2,
        ),
      ),
      width: 25,
      height: 25,
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: CustomColors.whBrightGrey,
        ),
        width: 4,
        height: 4,
      ),
    );
  }
}

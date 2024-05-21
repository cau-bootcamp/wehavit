import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';

enum FriendListCellState { normal, applied, managing, toApply }

class FriendListCellWidget extends StatelessWidget {
  const FriendListCellWidget({
    super.key,
    required this.futureUserEntity,
    required this.cellState,
  });

  final EitherFuture<UserDataEntity> futureUserEntity;
  final FriendListCellState cellState;

  @override
  Widget build(BuildContext context) {
    Widget postfixButtonWidget = Container();
    switch (cellState) {
      case FriendListCellState.applied:
        postfixButtonWidget = Row(
          children: [
            SmallColoredButtonWidget(
              buttonLabel: '수락',
              onPressed: () {},
            ),
            const SizedBox(
              width: 8,
            ),
            SmallColoredButtonWidget(
              buttonLabel: '거절',
              backgroundColor: CustomColors.whBrightGrey,
              onPressed: () {},
            ),
          ],
        );
      case FriendListCellState.managing:
        postfixButtonWidget = SmallColoredButtonWidget(
          buttonLabel: '삭제',
          backgroundColor: CustomColors.whBrightGrey,
          onPressed: () {},
        );
      case FriendListCellState.toApply:
        postfixButtonWidget = SmallColoredButtonWidget(
          buttonLabel: '요청',
          onPressed: () {},
        );
      default:
        postfixButtonWidget = Container();
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: EitherFutureBuilder<UserDataEntity>(
        target: futureUserEntity,
        forWaiting: Row(
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
        forFail: Container(),
        mainWidgetCallback: (userEntity) {
          return Row(
            children: [
              ProfileImageCircleWidget(size: 60, url: userEntity.userImageUrl),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userEntity.userName ?? '',
                      style: const TextStyle(
                        color: CustomColors.whWhite,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      userEntity.aboutMe ?? '',
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
              postfixButtonWidget,
            ],
          );
        },
      ),
    );
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
                  hintText: '닉네임으로 친구 찾기',
                  hintStyle: TextStyle(
                    color: CustomColors.whWhite,
                    fontSize: 16,
                    height: 1.4,
                  ),
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: -8),
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

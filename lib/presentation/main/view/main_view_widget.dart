import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';

class TabBarIconLabelButton extends StatelessWidget {
  const TabBarIconLabelButton({
    required this.isSelected,
    this.iconImageName,
    this.iconData,
    required this.label,
    super.key,
  });

  final bool isSelected;
  final String? iconImageName;
  final IconData? iconData;
  final String label;

  final double iconWidth = 28;
  final double iconHeight = 28;

  @override
  Widget build(BuildContext context) {
    Widget iconWidget;

    if (iconImageName != null) {
      iconWidget = Padding(
        padding: const EdgeInsets.all(2),
        child: Image.asset(iconImageName!),
      );
    } else if (iconData != null) {
      iconWidget = Icon(
        iconData!,
        size: iconWidth,
      );
    } else {
      iconWidget = const Icon(Icons.error);
    }

    return Column(
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            isSelected ? CustomColors.whYellow : CustomColors.whWhite,
            BlendMode.srcATop, // 블렌딩 모드 (여기서는 오버레이될 이미지에 대한 설정)
          ),
          child: Container(
            alignment: Alignment.center,
            width: iconWidth,
            height: iconHeight,
            child: iconWidget,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? CustomColors.whYellow : CustomColors.whWhite,
          ),
        ),
      ],
    );
  }
}

class TabBarProfileImageButton extends StatelessWidget {
  const TabBarProfileImageButton({
    required this.isSelected,
    required this.futureUserDataEntity,
    super.key,
  });

  final bool isSelected;
  final EitherFuture<UserDataEntity> futureUserDataEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              // 테두리 스타일 설정
              color: isSelected ? CustomColors.whYellow : Colors.transparent,
              width: 3, // 테두리 두께
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            color: CustomColors.whBrightGrey,
          ),
          clipBehavior: Clip.hardEdge,
          child: EitherFutureBuilder<UserDataEntity>(
            target: futureUserDataEntity,
            forFail: Container(),
            forWaiting: Container(),
            mainWidgetCallback: (entity) {
              return CircleProfileImage(
                size: 40,
                url: entity.userImageUrl ??
                    'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSAOnLXSaPbc4K0IId0dSTI050OfwusYAyfQzMiCF6mrwNPVdmN',
              );
            },
          ),
        ),
      ],
    );
  }
}

class TabBarBackgroundBlurWidget extends StatelessWidget {
  const TabBarBackgroundBlurWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black45.withOpacity(0.1),
        ),
        clipBehavior: Clip.hardEdge,
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  CustomColors.whDarkBlack,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

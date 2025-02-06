import 'dart:ui' as ui;

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';
import 'package:wehavit/presentation/state/user_data/my_user_data_provider.dart';

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

  final double iconWidth = 24;
  final double iconHeight = 24;

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
          style: context.labelSmall?.bold.copyWith(
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
    super.key,
  });

  final bool isSelected;
  final double size = 40;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              // 테두리 스타일 설정
              color: isSelected ? CustomColors.whYellow : Colors.transparent,
              width: 2, // 테두리 두께
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            color: CustomColors.whBrightGrey,
          ),
          clipBehavior: Clip.hardEdge,
          child: Consumer(
            builder: (context, ref, child) {
              final asyncUserEntity = ref.watch(getMyUserDataProvider);

              return asyncUserEntity.when(
                data: (entity) {
                  return CircleProfileImage(size: size, url: entity.userImageUrl);
                },
                error: (_, __) {
                  return Container(
                    width: size,
                    height: size,
                    decoration: const BoxDecoration(
                      color: CustomColors.whGrey600,
                      shape: BoxShape.circle,
                    ),
                  );
                },
                loading: () {
                  return Container(
                    width: size,
                    height: size,
                    decoration: const BoxDecoration(
                      color: CustomColors.whGrey600,
                      shape: BoxShape.circle,
                    ),
                  );
                },
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

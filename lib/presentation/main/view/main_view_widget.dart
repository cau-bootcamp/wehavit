import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';

class TabBarIconLabelButton extends StatelessWidget {
  const TabBarIconLabelButton({
    required this.isSelected,
    required this.iconImageName,
    required this.label,
    super.key,
  });

  final bool isSelected;
  final String iconImageName;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            isSelected ? CustomColors.whYellow : CustomColors.whWhite,
            BlendMode.srcATop, // 블렌딩 모드 (여기서는 오버레이될 이미지에 대한 설정)
          ),
          child: Image(
            image: AssetImage(iconImageName),
            width: 32,
            height: 32,
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
    return Container(
      width: 45,
      height: 45,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      clipBehavior: Clip.hardEdge,
      child: FutureBuilder<Either<Failure, UserDataEntity>>(
        future: futureUserDataEntity,
        builder: (context, snapshot) {
          if (!snapshot.hasData ||
              snapshot.hasError ||
              snapshot.data!.isLeft()) {
            return Container(
              color: CustomColors.whBrightGrey,
            );
          }

          return snapshot.data!.fold(
            (failure) => Container(
              color: CustomColors.whBrightGrey,
            ),
            (entity) => Image.network(
              entity.userImageUrl ??
                  'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSAOnLXSaPbc4K0IId0dSTI050OfwusYAyfQzMiCF6mrwNPVdmN',
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/presentation/presentation.dart';

enum UploadPhotoBottomToolbarType {
  upload,
  regret;
}

class UploadPhotoBottomToolbar extends StatelessWidget {
  const UploadPhotoBottomToolbar({
    this.type = UploadPhotoBottomToolbarType.upload,
    this.iconString = WHIcons.uploadPhoto,
    required this.onIconPressed,
    this.actionLabel = '공유하기',
    required this.onActionPressed,
    super.key,
  });

  final UploadPhotoBottomToolbarType type;
  final String iconString;
  final VoidCallback onIconPressed;
  final String actionLabel;
  final VoidCallback onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        WhIconButton(
          onPressed: type == UploadPhotoBottomToolbarType.upload ? onIconPressed : () {},
          iconString: iconString,
          size: WHIconsize.medium,
          color: type == UploadPhotoBottomToolbarType.upload ? CustomColors.whGrey900 : CustomColors.whGrey600,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            type == UploadPhotoBottomToolbarType.upload ? '인증샷은 최대 3장까지 공유할 수 있어요' : '반성글에서는 인증샷을 공유할 수 없어요',
            style: context.labelMedium?.copyWith(color: CustomColors.whGrey600),
          ),
        ),
        TextButton(
          onPressed: onActionPressed,
          style: TextButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            alignment: Alignment.centerLeft,
          ),
          child: Text(
            actionLabel,
            style: context.titleSmall?.bold.copyWith(color: CustomColors.whYellow500),
          ),
        ),
      ],
    );
  }
}

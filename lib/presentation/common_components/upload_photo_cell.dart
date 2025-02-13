import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/common/utils/image_uploader.dart';
import 'package:wehavit/presentation/presentation.dart';

class UploadPhotoCell extends StatelessWidget {
  const UploadPhotoCell({
    super.key,
    required this.imageFile,
    required this.state,
    required this.onCancel,
    required this.onRetry,
  });

  final File imageFile;
  final ImageUploadStatus state;
  final VoidCallback onCancel;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final indicator = switch (state) {
      ImageUploadStatus.uploading => Container(
          width: 90,
          height: 90,
          color: CustomColors.whGrey100.withOpacity(0.4),
          alignment: Alignment.center,
          child: const SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              color: CustomColors.whYellow500,
            ),
          ),
        ),
      ImageUploadStatus.fail => Container(
          width: 90,
          height: 90,
          color: CustomColors.whGrey100.withOpacity(0.6),
          alignment: Alignment.center,
          child: WhIconButton(
            size: WHIconsize.large,
            iconString: WHIcons.retry,
            color: CustomColors.whRed500,
            onPressed: onRetry,
          ),
        ),
      ImageUploadStatus.success => Container(),
    };

    final cancelButton = WhIconButton(
      iconString: WHIcons.xMarkCircle,
      size: WHIconsize.small,
      onPressed: onCancel,
    );

    return Stack(
      alignment: Alignment.topRight,
      children: [
        SizedBox(
          width: 90,
          height: 90,
          child: Image.file(
            imageFile,
            fit: BoxFit.cover,
          ),
        ),
        indicator,
        cancelButton,
      ],
    );
  }
}

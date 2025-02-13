import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:wehavit/common/utils/isolate_helper.dart';

enum ImageUploadStatus {
  uploading,
  success,
  fail;
}

class ImageUploadEntity {
  ImageUploadEntity({required this.imageFile, required this.index, required this.status});

  XFile imageFile;
  String resultUrl = '';
  int index;
  ImageUploadStatus status;
}

class ImageUploader with IsolateHelperMixin {
  Future<ImageUploadEntity> uploadFile(ImageUploadEntity entity) async {
    return loadWithIsolate(
      () async {
        await Future.delayed(Duration(seconds: Random().nextInt(4)));
        return entity..status = ImageUploadStatus.fail;
      },
    );
  }
}

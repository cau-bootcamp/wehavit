import 'package:camera/camera.dart';

enum ImageUploadStatus {
  uploading,
  success,
  fail;
}

class ImageUploadEntity {
  ImageUploadEntity({required this.imageFile, required this.status});

  XFile imageFile;
  String resultUrl = '';
  ImageUploadStatus status;
}

/// ImageUploader를 통해 Isolate로 이미지 업로드 로직을 분리하고자 하였으나,
/// 기존의 방식만을 적용했을 때에도 큰 문제 없이 이미지의 업로드가 가능해, ImageUploader를 잠시 폐기합니다. 
// class ImageUploader with IsolateHelperMixin {
//   ImageUploader();

//   Future<ImageUploadEntity> uploadFile(ImageUploadEntity entity, String uid) async {
//     return loadWithIsolate(
//       () async {
//         // final result = await _upload(entity, uid);

//         // return result.fold(
//         //   (failure) {
//         //     // return (entity..status = ImageUploadStatus.fail);
//         //     return entity..status = ImageUploadStatus.success;
//         //   },
//         //   (url) {
//         //     // return (entity
//         //     //   ..status = ImageUploadStatus.success
//         //     //   ..resultUrl = url);
//         //     return entity..status = ImageUploadStatus.success;
//         //   },
//         // );

//         return entity..status = ImageUploadStatus.success;
//       },
//     );
//   }

//   EitherFuture<String> _upload(ImageUploadEntity entity, String uid) async {
//     try {
//       String storagePath = FirebaseConfirmPostImagePathName.storagePath(uid: uid);
//       final ref = FirebaseStorage.instance.ref(storagePath);
//       await ref.putFile(File(entity.imageFile.path));

//       return Future(() async => right(await ref.getDownloadURL()));
//     } on Exception catch (e) {
//       return Future(() => left(Failure(e.toString())));
//     }
//   }
// }

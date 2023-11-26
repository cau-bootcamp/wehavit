import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/features/my_page/domain/models/resolution_model.dart';

class LateWritingViewModel {
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController contentTextEditingController = TextEditingController();

  EitherFuture<List<ResolutionModel>> resolutionList = Future(
    () => right([]),
  );
  int resolutionIndex = 0;

  String? imageFileUrl;
}

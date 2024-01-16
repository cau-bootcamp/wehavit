import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/domain/entities/resolution_entity/resolution_entity.dart';

class LateWritingViewModel {
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController contentTextEditingController = TextEditingController();

  EitherFuture<List<ResolutionEntity>> resolutionList = Future(
    () => right([]),
  );

  int resolutionIndex = 0;
  String? imageFileUrl;
}

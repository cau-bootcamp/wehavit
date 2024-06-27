import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';

class ResolutionListCellWidgetModel {
  ResolutionListCellWidgetModel({
    required this.entity,
    required this.doneList,
  });

  ResolutionEntity entity;
  EitherFuture<List<bool>> doneList;
}

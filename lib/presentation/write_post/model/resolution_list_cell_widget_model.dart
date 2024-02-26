import 'package:wehavit/domain/entities/entities.dart';

class ResolutionListCellWidgetModel {
  ResolutionListCellWidgetModel({
    required this.entity,
    required this.successCount,
  });

  ResolutionEntity entity;
  int successCount;
}

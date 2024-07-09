import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/group_post/model/group_post_view_model.dart';
import 'package:wehavit/presentation/presentation.dart';

class ResolutionDetailViewModel extends PostViewModel {
  ResolutionDetailViewModel();

  ResolutionEntity? resolutionEntity;

  static final mondayOfThisWeek = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  ).subtract(Duration(days: DateTime.now().weekday - 1));
}

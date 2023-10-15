import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/features/my_page/data/datasources/resolution_datasource.dart';
import 'package:wehavit/features/my_page/domain/models/resolution_model.dart';

class ResolutionRemoteDatasourceImpl implements ResolutionDatasource {
  @override
  Future<Either<Failure, List<ResolutionModel>>> getResolutionModelList() {
    // TODO: Firebase 호출 작업 필요함
    // throw UnimplementedError();
    return Future.delayed(Duration(milliseconds: 1000), () {
      return Right(<ResolutionModel>[
        ResolutionModel(
          goal: "Hello",
          action: "world",
          period: 1111100,
          startDate: DateTime.now(),
        ),
      ]);
    });
  }
}

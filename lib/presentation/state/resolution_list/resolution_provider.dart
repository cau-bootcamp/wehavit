import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';

final resolutionProvider = FutureProvider.family<ResolutionEntity, ResolutionProviderParam>(
  (ref, param) => ref
      .read(getTargetResolutionEntityUsecaseProvider)
      .call(targetResolutionId: param.resolutionId, targetUserId: param.userId)
      .then(
        (result) => result.fold(
          (failure) => Future.error(failure.message),
          (success) => success,
        ),
      ),
);

class ResolutionProviderParam {
  ResolutionProviderParam({required this.userId, required this.resolutionId});

  final String userId;
  final String resolutionId;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResolutionProviderParam && other.userId == userId && other.resolutionId == resolutionId;
  }

  @override
  int get hashCode => userId.hashCode ^ resolutionId.hashCode;
}

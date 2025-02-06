import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/dependency/dependency.dart';
import 'package:wehavit/domain/entities/group_entity/group_entity.dart';

final groupProvider = FutureProvider.family<GroupEntity, String>(
  (ref, groupId) => ref
      .read(getGroupEntityByIdUsecaseProvider)
      .call(groupId: groupId)
      .then((result) => result.fold((failure) => Future.error(failure.message), (success) => success)),
);

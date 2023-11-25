import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wehavit/common/constants/firebase_field_name.dart';
import 'package:wehavit/common/errors/failure.dart';
import 'package:wehavit/common/utils/custom_types.dart';
import 'package:wehavit/common/utils/firebase_collection_name.dart';
import 'package:wehavit/features/home/data/datasources/confirm_post_datasource.dart';
import 'package:wehavit/features/home/data/entities/confirm_post_entity.dart';
import 'package:wehavit/features/home/domain/models/confirm_post_model.dart';

class ConfirmPostRemoteDatasourceImpl implements ConfirmPostDatasource {
  @override
  EitherFuture<List<ConfirmPostEntity>> getConfirmPostEntityList() async {
    return;
  }
}

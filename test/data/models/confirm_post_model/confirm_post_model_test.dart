import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:wehavit/data/models/firebase_models/confirm_post_model/confirm_post_model.dart';
import 'package:wehavit/domain/entities/entities.dart';

import 'confirm_post_model_test.mocks.dart';

@GenerateNiceMocks([MockSpec<DocumentSnapshot>()])
void main() {
  group('[FirebaseConfirmPostModel 테스트]', () {
    test('1. 모델 생성 및 필드 검증', () {
      final model = FirebaseConfirmPostModel(
        resolutionGoalStatement: 'Test Goal',
        resolutionId: 'Test Resolution ID',
        title: 'Test Title',
        content: 'Test Content',
        imageUrl: 'Test Image URL',
        owner: 'Test Owner',
        recentStrike: 1,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        attributes: {'Test Attribute': true},
      );

      expect(model, isA<FirebaseConfirmPostModel>());

      expect(model.resolutionGoalStatement, 'Test Goal');
      expect(model.resolutionId, 'Test Resolution ID');
      expect(model.title, 'Test Title');
      expect(model.content, 'Test Content');
      expect(model.imageUrl, 'Test Image URL');
      expect(model.owner, 'Test Owner');
      expect(model.recentStrike, 1);
      expect(model.createdAt, isA<DateTime>());
      expect(model.updatedAt, isA<DateTime>());
      expect(model.attributes, {'Test Attribute': true});
    });

    test('2. fromJson 메서드 검증', () {
      final json = {
        'resolutionGoalStatement': 'Test Goal',
        'resolutionId': 'Test Resolution ID',
        'title': 'Test Title',
        'content': 'Test Content',
        'imageUrl': 'Test Image URL',
        'owner': 'Test Owner',
        'recentStrike': 1,
        'createdAt': Timestamp.fromDate(DateTime.now()),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
        'attributes': {'Test Attribute': true},
      };

      // fromJson 메서드 검증
      final modelFromJson = FirebaseConfirmPostModel.fromJson(json);

      expect(modelFromJson, isA<FirebaseConfirmPostModel>());

      expect(modelFromJson.resolutionGoalStatement, 'Test Goal');
      expect(modelFromJson.resolutionId, 'Test Resolution ID');
      expect(modelFromJson.title, 'Test Title');
      expect(modelFromJson.content, 'Test Content');
      expect(modelFromJson.imageUrl, 'Test Image URL');
      expect(modelFromJson.owner, 'Test Owner');
      expect(modelFromJson.recentStrike, 1);
      expect(modelFromJson.createdAt, isA<DateTime>());
      expect(modelFromJson.updatedAt, isA<DateTime>());
      expect(modelFromJson.attributes, {'Test Attribute': true});
    });

    test('3. fromFireStoreDocument 메서드 검증', () {
      // Mock 객체 생성
      final doc = MockDocumentSnapshot();

      // Mock 객체에 대한 동작 정의
      when(doc.data()).thenReturn({
        'resolutionGoalStatement': 'Test Goal',
        'resolutionId': 'Test Resolution ID',
        'title': 'Test Title',
        'content': 'Test Content',
        'imageUrl': 'Test Image URL',
        'owner': 'Test Owner',
        'recentStrike': 1,
        'createdAt': Timestamp.fromDate(DateTime.now()),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
        'attributes': {'Test Attribute': true},
      });

      // fromFireStoreDocument 메서드를 사용하여 모델 생성
      final modelFromFirestore =
          FirebaseConfirmPostModel.fromFireStoreDocument(doc);

      expect(modelFromFirestore, isA<FirebaseConfirmPostModel>());

      expect(modelFromFirestore.resolutionGoalStatement, 'Test Goal');
      expect(modelFromFirestore.resolutionId, 'Test Resolution ID');
      expect(modelFromFirestore.title, 'Test Title');
      expect(modelFromFirestore.content, 'Test Content');
      expect(modelFromFirestore.imageUrl, 'Test Image URL');
      expect(modelFromFirestore.owner, 'Test Owner');
      expect(modelFromFirestore.recentStrike, 1);
      expect(modelFromFirestore.createdAt, isA<DateTime>());
      expect(modelFromFirestore.updatedAt, isA<DateTime>());
      expect(modelFromFirestore.attributes, {'Test Attribute': true});
    });

    test('4. toConfirmPostEntity 메서드 검증', () {
      final model = FirebaseConfirmPostModel(
        resolutionGoalStatement: 'Test Goal',
        resolutionId: 'Test Resolution ID',
        title: 'Test Title',
        content: 'Test Content',
        imageUrl: 'Test Image URL',
        owner: 'Test Owner',
        recentStrike: 1,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        attributes: {'Test Attribute': true},
      );

      final entity =
          model.toConfirmPostEntity('Test ID', UserDataEntity.dummyModel);

      expect(entity, isA<ConfirmPostEntity>());

      expect(entity.id, 'Test ID');
      expect(entity.resolutionGoalStatement, 'Test Goal');
      expect(entity.resolutionId, 'Test Resolution ID');
      expect(entity.title, 'Test Title');
      expect(entity.content, 'Test Content');
      expect(entity.imageUrl, 'Test Image URL');
      expect(entity.owner, isNot('Test Owner'));
      expect(entity.owner, UserDataEntity.dummyModel.userId);
      expect(entity.recentStrike, 1);
      expect(entity.createdAt, isA<DateTime>());
      expect(entity.updatedAt, isA<DateTime>());
      expect(entity.attributes, {'Test Attribute': true});
    });

    test('5. toFirestoreMap 메서드 검증', () {
      final model = FirebaseConfirmPostModel(
        resolutionGoalStatement: 'Test Goal',
        resolutionId: 'Test Resolution ID',
        title: 'Test Title',
        content: 'Test Content',
        imageUrl: 'Test Image URL',
        owner: 'Test Owner',
        recentStrike: 1,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        attributes: {'Test Attribute': true},
      );

      final map = model.toFirestoreMap();

      expect(map, {
        'resolutionGoalStatement': 'Test Goal',
        'resolutionId': 'Test Resolution ID',
        'title': 'Test Title',
        'content': 'Test Content',
        'imageUrl': 'Test Image URL',
        'owner': 'Test Owner',
        'recentStrike': 1,
        'createdAt': Timestamp.fromDate(model.createdAt!),
        'updatedAt': Timestamp.fromDate(model.updatedAt!),
        'attributes': {'Test Attribute': true},
      });
    });
  });
}

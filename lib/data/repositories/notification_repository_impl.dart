import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:wehavit/domain/repositories/repositories.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  @override
  Future<void> sendNotification({
    required String title,
    required String content,
    required List<String> targetTokenList,
  }) async {
    final jsonCredentials =
        await rootBundle.loadString('.env/we-havit-be-111008c5229d.json');
    final creds = auth.ServiceAccountCredentials.fromJson(jsonCredentials);
    final client = await auth.clientViaServiceAccount(
      creds,
      ['https://www.googleapis.com/auth/cloud-platform'],
    );

    for (var token in targetTokenList) {
      var response = await client.post(
        Uri.parse(
            'https://fcm.googleapis.com/v1/projects/764897522660/messages:send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'project_id': '764897522660',
        },
        body: jsonEncode(
          <String, dynamic>{
            'message': {
              'token': token,
              'notification': {
                'title': title,
                'body': content,
              },
            },
          },
        ),
      );

      if (response.statusCode == 200) {
        print("send");
      } else {
        print("send fail");
      }
    }
  }
}

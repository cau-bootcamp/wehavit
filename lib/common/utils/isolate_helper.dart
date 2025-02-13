// 출처 : https://velog.io/@ximya_hf/flutter-isolate

import 'dart:async';
import 'dart:collection';
import 'dart:isolate';
import 'package:flutter/services.dart';

// Isolate를 다루는 mixin 클래스
mixin IsolateHelperMixin {
  // 동시에 실행할 수 있는 Isolate의 최대 개수 설정
  static const int _maxIsolates = 3;

  // 현재 실행 중인 Isolate의 개수를 추적
  int _currentIsolates = 0;

  // 보류 중인 작업을 저장하는 큐
  final Queue<Function> _taskQueue = Queue();

  // Isolate를 생성하여 함수를 실행하거나, 만약 현재 실행 중인 Isolate의 개수가 최대치에 도달한 경우 큐에 작업을 추가
  Future<T> loadWithIsolate<T>(Future<T> Function() function) async {
    if (_currentIsolates < _maxIsolates) {
      _currentIsolates++;
      return _executeIsolate(function);
    } else {
      final completer = Completer<T>();
      _taskQueue.add(() async {
        final result = await _executeIsolate(function);
        completer.complete(result);
      });
      return completer.future;
    }
  }

  // 새로운 Isolate를 생성하여 주어진 함수를 실행
  Future<T> _executeIsolate<T>(Future<T> Function() function) async {
    final ReceivePort receivePort = ReceivePort();
    final RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;

    final isolate = await Isolate.spawn(
      _isolateEntry,
      _IsolateEntryPayload(
        function: function,
        sendPort: receivePort.sendPort,
        rootIsolateToken: rootIsolateToken,
      ),
    );

    // Isolate의 결과를 받고, 이 Isolate를 종료한 후, 큐에서 다음 작업을 실행
    return receivePort.first.then(
      (dynamic data) {
        _currentIsolates--;
        _runNextTask();
        if (data is T) {
          isolate.kill(priority: Isolate.immediate);
          return data;
        } else {
          isolate.kill(priority: Isolate.immediate);
          throw data;
        }
      },
    );
  }

  // 큐에서 다음 작업을 꺼내어 실행
  void _runNextTask() {
    if (_taskQueue.isNotEmpty) {
      final nextTask = _taskQueue.removeFirst();
      nextTask();
    }
  }
}

// Isolate에서 실행되는 함수
Future<void> _isolateEntry(_IsolateEntryPayload payload) async {
  final Function function = payload.function;

  try {
    BackgroundIsolateBinaryMessenger.ensureInitialized(
      payload.rootIsolateToken,
    );
  } on MissingPluginException catch (e) {
    print(e.toString());
    return Future.error(e.toString());
  }

  // payload로 전달받은 함수 실행 후 결과를 sendPort를 통해 메인 Isolate로 보냄
  final result = await function();
  payload.sendPort.send(result);
}

// Isolate 생성 시 필요한 데이터를 담는 클래스
class _IsolateEntryPayload {
  const _IsolateEntryPayload({
    required this.function,
    required this.sendPort,
    required this.rootIsolateToken,
  });

  final Future<dynamic> Function() function; // Isolate에서 실행할 함수
  final SendPort sendPort; // 메인 Isolate로 데이터를 보내기 위한 SendPort
  final RootIsolateToken rootIsolateToken; // Isolate간 통신을 위한 토큰
}

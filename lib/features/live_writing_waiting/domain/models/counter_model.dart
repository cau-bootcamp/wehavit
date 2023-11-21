import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'counter_model.g.dart';

@riverpod
class Counter extends _$Counter {
  @override
  int build() => 0;

  void increment() => state++;
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wehavit/legacy/live_writing/presentation/screens/live_writing_view.dart';

final timeProvider = StateProvider<DateTime>((ref) => DateTime.now());

class LiveWaitingSampleView extends ConsumerWidget {
  const LiveWaitingSampleView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const LiveWritingView();
  }
}

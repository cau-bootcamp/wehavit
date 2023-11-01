import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LiveWritingPage extends ConsumerWidget {
  const LiveWritingPage({super.key});

  static LiveWritingPage builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const LiveWritingPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: const Text('Live Writing'),
      ),
    );
  }
}

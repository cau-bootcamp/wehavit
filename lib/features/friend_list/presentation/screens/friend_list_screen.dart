import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FriendListScreen extends ConsumerWidget {
  const FriendListScreen({super.key});

  static FriendListScreen builder(
      BuildContext context,
      GoRouterState state,
      ) =>
      const FriendListScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: TextButton(
          child: Text(
            'friendList',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          onPressed: () async {
            context.push('/myPage');
          },
        ),
      ),
    );
  }
}

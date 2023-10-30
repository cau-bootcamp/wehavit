import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/theme/theme.dart';

import '../../features/auth/auth.dart';

class ErrorScreen extends ConsumerWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = context.textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Something went wrong',
          style: textTheme.headlineSmall,
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await ref.read(authProvider.notifier).logOut();
            // context.go(RouteLocation.home);
          },
          child: Text(
            'Log out and Go to home',
            style: textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}

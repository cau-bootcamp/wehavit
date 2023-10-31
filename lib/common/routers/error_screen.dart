import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wehavit/common/routers/route_location.dart';
import 'package:wehavit/common/theme/theme.dart';

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
            context.go(RouteLocation.auth);
          },
          child: Text(
            'Go to Home Page',
            style: textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wehavit/common/routers/route_location.dart';
import 'package:wehavit/common/theme/theme.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Something went wrong',
          style: textTheme.headlineMedium,
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go(RouteLocation.home),
          child: Text(
            'Go to home',
            style: textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}

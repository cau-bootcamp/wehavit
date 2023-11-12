import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/auth/presentation/providers/auth_provider.dart';

class TestPage extends ConsumerWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = context.textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '[DEV] TEST PAGE',
          style: textTheme.headlineSmall,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MoveButton(
              onPressCallback: () async {
                context.go(RouteLocation.myPage);
              },
              buttonText: 'Go to My Page',
            ),
            MoveButton(
              onPressCallback: () async {
                context.go(RouteLocation.addResolution);
              },
              buttonText: 'Go to Add Resolution Page',
            ),
            MoveButton(
              onPressCallback: () async {
                context.go(RouteLocation.home);
              },
              buttonText: 'Go to Main View',
            ),
            MoveButton(
              onPressCallback: () async {
                context.go(RouteLocation.friendList);
              },
              buttonText: 'Go to Friends List View',
            ),
            MoveButton(
              onPressCallback: () async {
                context.go(RouteLocation.profile);
              },
              buttonText: 'Go to Profile Page',
            ),
            MoveButton(
              onPressCallback: () async {
                context.go(RouteLocation.liveWriting);
              },
              buttonText: 'Go to LiveWriting Page',
            ),
            MoveButton(
              onPressCallback: () async {
                context.go(RouteLocation.auth);
              },
              buttonText: 'Go to Login Page',
            ),
            MoveButton(
              onPressCallback: () async {
                ref.read(authProvider.notifier).logOut();
              },
              buttonText: 'Log out',
            ),
          ],
        ),
      ),
    );
  }
}

class MoveButton extends StatelessWidget {
  const MoveButton({
    super.key,
    required this.onPressCallback,
    required this.buttonText,
  });

  final void Function()? onPressCallback;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressCallback,
      child: Text(
        buttonText,
        style: context.textTheme.bodyMedium,
      ),
    );
  }
}

//
//
//        Flexible(
//          child: ElevatedButton(
//            onPressed: () async {
//              context.go(RouteLocation.myPage);
//            },
//            child: Text(
//              'Go to myPage',
//              style: textTheme.bodyMedium,
//            ),
//          ),
//        ),

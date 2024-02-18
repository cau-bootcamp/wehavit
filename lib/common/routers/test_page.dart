import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';

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
                context.push(RouteLocation.home);
              },
              buttonText: 'Go to Main View',
            ),
            MoveButton(
              onPressCallback: () async {
                context.push(RouteLocation.myPage);
              },
              buttonText: 'Go to My Page',
            ),
            MoveButton(
              onPressCallback: () async {
                context.push(RouteLocation.friendList);
              },
              buttonText: 'Go to Friends List View',
            ),
            MoveButton(
              onPressCallback: () async {
                context.push(RouteLocation.groupSampleView);
              },
              buttonText: 'Go to Group Sample View',
            ),
            MoveButton(
              onPressCallback: () async {
                context.push(RouteLocation.groupView);
              },
              buttonText: 'Go to Group View',
            ),
            MoveButton(
              onPressCallback: () async {
                context.push(RouteLocation.addResolution);
              },
              buttonText: 'Go to Add Resolution Page',
            ),
            MoveButton(
              onPressCallback: () async {
                context.push('/reactionSampleView');
              },
              buttonText: 'Reaction Sample View',
            ),
            MoveButton(
              onPressCallback: () async {
                context.push('/animationSampleView');
              },
              buttonText: 'Animation Sample View',
            ),
            MoveButton(
              onPressCallback: () async {
                context.push('/lateWritingView');
              },
              buttonText: 'Write Confirm Post View',
            ),
            MoveButton(
              onPressCallback: () async {
                context.push(RouteLocation.auth);
              },
              buttonText: 'Go to Login Page',
            ),
            MoveButton(
              onPressCallback: () async {
                ref.read(authProvider.notifier).logOut();
              },
              buttonText: 'Log out',
            ),
            MoveButton(
              onPressCallback: () async {
                context.push('/route/to/nowhere');
              },
              buttonText: 'Go to Error View',
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

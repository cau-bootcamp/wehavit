import 'package:flutter/material.dart';
import 'package:wehavit/common/common.dart';

class EitherFutureBuilder<T> extends StatelessWidget {
  const EitherFutureBuilder({
    required this.target,
    required this.forWaiting,
    required this.forFail,
    required this.mainWidgetCallback,
    super.key,
  });

  final EitherFuture target;
  final Widget forWaiting;
  final Widget Function(T) mainWidgetCallback;
  final Widget forFail;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: target,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return forWaiting;
        }

        if (snapshot.hasData && snapshot.data!.isRight()) {
          final data = snapshot.data!.getOrElse(
            (failure) {
              return Object() as T;
            },
          );

          return mainWidgetCallback(data!);
        }
        return forFail;
      },
    );
  }
}

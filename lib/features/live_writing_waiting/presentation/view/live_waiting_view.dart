import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wehavit/features/live_writing_waiting/presentation/view/widget/live_waiting_avatar_animation_widget.dart';

Stream<int> counterStream() {
  return Stream.periodic(const Duration(seconds: 1), (i) => i + 1);
}

class LiveWritingView extends HookConsumerWidget {
  const LiveWritingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stream = useMemoized(() => counterStream());
    final snapshot = useStream<int>(stream, initialData: 0);
    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: List.generate(
              5,
              (_) => const LiveWaitingAvatarAnimatingWidget(
                userImageUrl:
                    'https://mblogthumb-phinf.pstatic.net/MjAyMDA0MDlfMzgg/MDAxNTg2NDEyNjMwNTU2.tj79WwOeb17w8C0PQWXqebTyUyTT6pfCNVOoCSzBOaIg.8vfG4lXr0u-LZdHOoWGUSIKzsXwoa5zGuYkdrwqu1vcg.PNG.klipk2/먼지1.png?type=w800',
              ),
            ),
          ),
          Positioned(
            top: 100,
            child: Column(
              children: [
                const Text(
                  '곧 입장을 시작합니다',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  '입장 중',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${snapshot.hasError || snapshot.hasData ? snapshot.data! ~/ 60 : 00}'
                          .padLeft(2, '0') +
                      ':' +
                      '${snapshot.hasError || snapshot.hasData ? snapshot.data! % 60 : 00}'
                          .padLeft(2, '0'),
                  style: const TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wehavit/features/live_writing_waiting/presentation/view/live_waiting_view.dart';

final timeProvider = StateProvider<DateTime>((ref) => DateTime.now());

class LiveWaitingSampleView extends ConsumerStatefulWidget {
  const LiveWaitingSampleView({super.key});

  @override
  ConsumerState<LiveWaitingSampleView> createState() =>
      _LiveWaitingSampleViewState();
}

class _LiveWaitingSampleViewState extends ConsumerState<LiveWaitingSampleView> {
  late LiveWaitingViewUserImageUrlList _imageUrlListProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _imageUrlListProvider =
        ref.read(liveWaitingViewUserImageUrlListProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black,
                    Colors.amber,
                  ],
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  _imageUrlListProvider.addUserImageUrl(
                    imageUrl:
                        'https://avatars.githubusercontent.com/u/63251068?v=4',
                  );
                },
                child: const Text('Add User')),
            const LiveWritingView(),
          ],
        ),
      ),
    );
  }
}

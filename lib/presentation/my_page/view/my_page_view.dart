import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/dependency/domain/usecase_dependency.dart';
import 'package:wehavit/dependency/presentation/viewmodel_dependency.dart';
import 'package:wehavit/domain/entities/entities.dart';
import 'package:wehavit/presentation/presentation.dart';

class MyPageView extends ConsumerStatefulWidget {
  const MyPageView(this.index, this.tabController, {super.key});

  final int index;
  final TabController tabController;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends ConsumerState<MyPageView>
    with AutomaticKeepAliveClientMixin<MyPageView> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(_handleTabChange);

    unawaited(ref.read(myPageViewModelProvider.notifier).loadData());
  }

  @override
  void dispose() {
    // 리스너 제거
    widget.tabController.removeListener(_handleTabChange);
    super.dispose();
  }

  void _handleTabChange() {
    if (widget.tabController.index == widget.index) {
      // 탭바에서 화면이 MainView로 전환되면 setState를 호출
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final viewModel = ref.watch(myPageViewModelProvider);
    final provider = ref.watch(myPageViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: CustomColors.whDarkBlack,
      appBar: WehavitAppBar(
        title: '내 정보',
        trailingTitle: '로그아웃',
        trailingAction: () async {
          final userEntity = await ref
              .read(getMyUserDataUsecaseProvider)
              .call()
              .then((result) {
            return result.fold((failure) {
              return null;
            }, (entity) {
              return entity;
            });
          });
          if (userEntity != null) {
            final documentDirectory = await getApplicationDocumentsDirectory();
            final file = File('${documentDirectory.path}/downloaded_image.jpg');
            try {
              // HTTP GET 요청을 통해 이미지 데이터 다운로드
              final response =
                  await http.get(Uri.parse(userEntity.userImageUrl!));
              if (response.statusCode == 200) {
                // 임시 디렉토리에 파일 저장 경로 생성

                // 파일로 이미지 데이터 저장
                file.writeAsBytesSync(response.bodyBytes);
              } else {
                throw Exception('이미지 다운로드 실패');
              }
            } catch (e) {
              print('이미지 다운로드 중 오류 발생: $e');
            }

            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return EditUserDetailView(
                isModifying: true,
                uid: userEntity.userId,
                profileImageFile: file,
                name: userEntity.userName,
                handle: userEntity.handle,
                aboutMe: userEntity.aboutMe,
              );
            }));
          }

          // await ref.read(logOutUseCaseProvider).call();
          // if (mounted) {
          //   // ignore: use_build_context_synchronously
          //   Navigator.pushReplacementNamed(context, '/entrance');
          // }
        },
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: RefreshIndicator(
          onRefresh: () async {
            provider.loadData().whenComplete(() {
              setState(() {});
            });
          },
          child: ListView(
            padding: const EdgeInsets.only(bottom: 64.0),
            children: [
              // 내 프로필
              MyPageWehavitSummaryWidget(
                futureUserEntity: viewModel.futureMyUserDataEntity,
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                '도전중인 목표',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              EitherFutureBuilder<List<ResolutionEntity>>(
                target: viewModel.futureMyyResolutionList,
                forWaiting: Container(),
                forFail: Container(),
                mainWidgetCallback: (resolutionList) {
                  return Column(
                    children: List<ResolutionListCellWidget>.generate(
                      resolutionList.length,
                      (index) => ResolutionListCellWidget(
                        resolutionEntity: resolutionList[index],
                        showDetails: true,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

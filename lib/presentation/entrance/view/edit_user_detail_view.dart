import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/constants/constants.dart';
import 'package:wehavit/dependency/dependency.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';
import 'package:wehavit/presentation/main/main.dart';

class EditUserDetailView extends ConsumerStatefulWidget {
  const EditUserDetailView({
    required this.isModifying,
    this.uid,
    this.profileImageUrl,
    this.name,
    this.handle,
    this.aboutMe,
    super.key,
  });

  final bool isModifying;
  final String? uid;
  final String? profileImageUrl;
  final String? name;
  final String? handle;
  final String? aboutMe;

  @override
  ConsumerState<EditUserDetailView> createState() => _EditUserDetailViewState();
}

class _EditUserDetailViewState extends ConsumerState<EditUserDetailView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    final viewmodel = ref.watch(editUserDataViewModelProvider);
    final userId = await ref
        .read(getMyUserIdUsecaseProvider)
        .call()
        .then((result) => result.fold((failure) => null, (id) => id));

    viewmodel.uid = widget.uid ?? (userId ?? '');

    if (widget.isModifying) {
      loadDataFromArguments().whenComplete(() {
        setState(() {});
      });
    }
  }

  Future<void> loadDataFromArguments() async {
    final viewmodel = ref.watch(editUserDataViewModelProvider);

    viewmodel.name = widget.name ?? '';
    viewmodel.handle = widget.handle ?? '';
    viewmodel.aboutMe = widget.aboutMe ?? '';

    await ref
        .read(editUserDataViewModelProvider.notifier)
        .downloadImageToFile(widget.profileImageUrl!);
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = ref.watch(editUserDataViewModelProvider);
    final provider = ref.read(editUserDataViewModelProvider.notifier);

    UniqueKey imageKey = UniqueKey();

    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: CustomColors.whDarkBlack,
          appBar: WehavitAppBar(
            title: widget.isModifying ? '내 정보 수정' : '회원가입',
            leadingTitle: '',
            leadingIcon: Icons.chevron_left,
            leadingAction: () async {
              if (!widget.isModifying) {
                try {
                  await provider.removeUserData();
                  await provider.logOut();
                } on Exception catch (e) {
                  // ignore: avoid_print
                  print('DEBUG: ${e.toString()}');
                }
              }

              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
          ),
          body: SafeArea(
            minimum: const EdgeInsets.symmetric(horizontal: 16.0),
            maintainBottomViewPadding: true,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 24.0, bottom: 32.0),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              overlayColor: CustomColors.whYellow,
                            ),
                            onPressed: () async {
                              provider.pickProfileImage().whenComplete(
                                    () => setState(() {}),
                                  );
                            },
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: 85,
                                  height: 85,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: CustomColors.whGrey,
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  child: viewmodel.profileImage != null
                                      ? Image(
                                          image: viewmodel.profileImage!,
                                          key: imageKey,
                                          fit: BoxFit.cover,
                                        )
                                      : Container(),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: -5,
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: CustomColors.whWhite,
                                    ),
                                    child: const Icon(
                                      Icons.photo_camera,
                                      color: CustomColors.whBlack,
                                      size: 18.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '이름',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: CustomColors.whWhite,
                              fontSize: 20,
                            ),
                          ),
                          Container(
                            height: 8.0,
                          ),
                          TextFormField(
                            initialValue: widget.name,
                            onChanged: (value) {
                              provider.setName(value);
                              setState(() {});
                            },
                            cursorColor: CustomColors.whWhite,
                            textAlignVertical: TextAlignVertical.center,
                            style: const TextStyle(
                              color: CustomColors.whWhite,
                              fontSize: 16.0,
                            ),
                            decoration: InputDecoration(
                              hintText: '친구들에게 보여지는 이름이예요',
                              hintStyle: const TextStyle(
                                fontSize: 16,
                                color: CustomColors.whPlaceholderGrey,
                              ),
                              filled: true,
                              fillColor: CustomColors.whGrey,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              isCollapsed: true,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '사용자 ID',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: CustomColors.whWhite,
                              fontSize: 20,
                            ),
                          ),
                          Container(
                            height: 8.0,
                          ),
                          TextFormField(
                            initialValue: widget.handle,
                            onChanged: (value) {
                              provider.setHandle(value);
                              setState(() {});
                            },
                            cursorColor: CustomColors.whWhite,
                            textAlignVertical: TextAlignVertical.center,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9a-zA-Z!@#$%^&*(),.?":{}|<>_]'),
                              ),
                            ],
                            style: const TextStyle(
                              color: CustomColors.whWhite,
                              fontSize: 16.0,
                            ),
                            decoration: InputDecoration(
                              hintText: '친구가 나를 찾을 때 사용하는 ID예요',
                              hintStyle: const TextStyle(
                                fontSize: 16,
                                color: CustomColors.whPlaceholderGrey,
                              ),
                              filled: true,
                              fillColor: CustomColors.whGrey,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              isCollapsed: true,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '한 줄 소개',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: CustomColors.whWhite,
                              fontSize: 20,
                            ),
                          ),
                          Container(
                            height: 8.0,
                          ),
                          TextFormField(
                            initialValue: widget.aboutMe,
                            onChanged: (value) {
                              provider.setAboutMe(value);
                              setState(() {});
                            },
                            cursorColor: CustomColors.whWhite,
                            textAlignVertical: TextAlignVertical.center,
                            style: const TextStyle(
                              color: CustomColors.whWhite,
                              fontSize: 16.0,
                            ),
                            decoration: InputDecoration(
                              hintText: '나에 대해 소개해주세요',
                              hintStyle: const TextStyle(
                                fontSize: 16,
                                color: CustomColors.whPlaceholderGrey,
                              ),
                              filled: true,
                              fillColor: CustomColors.whGrey,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              isCollapsed: true,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Expanded(child: Container()),
                    ],
                  ),
                ),
                WideColoredButton(
                  onPressed: () async {
                    setState(() {
                      viewmodel.isProcessing = true;
                    });

                    // TODO : 현재 프로필사진을 바꾸지 않고 나머지 데이터만 변경하더라도
                    // 프로필사진을 다시 업로드하도록 구조가 작성되어있음
                    // 낭비되는 Storage를 줄이기 위해서 여기 부분 수정해주기
                    // (기존의 프로필사진은 삭제하는 방식도 고려해볼만 한 듯?)

                    await provider.registerUserData().then(
                          (result) => result.fold(
                            (failure) {
                              String toastMessage = '';
                              switch (failure.message) {
                                case 'handle-already-exist':
                                  toastMessage = '이미 사용중인 ID예요';
                                  break;
                                case 'no-image-file':
                                  toastMessage = '프로필 이미지를 업로드해주세요';
                                  break;
                                case 'no-handle':
                                  toastMessage = '사용자 ID를 업로드해주세요';
                                  break;
                                default:
                                  toastMessage = '잠시 후 다시 시도해주세요';
                                  break;
                              }

                              showToastMessage(
                                context,
                                text: toastMessage,
                                icon: const Icon(
                                  Icons.not_interested,
                                  color: PointColors.red,
                                ),
                              );
                            },
                            (success) async {
                              if (widget.isModifying) {
                                Navigator.pop(context, true);
                              } else {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    fullscreenDialog: true,
                                    builder: (context) => const MainView(),
                                  ),
                                );
                              }
                            },
                          ),
                        );
                    setState(() {
                      viewmodel.isProcessing = false;
                    });
                  },
                  isDiminished: !((viewmodel.name.isNotEmpty &
                              viewmodel.handle.isNotEmpty) &
                          (viewmodel.profileImage != null)) |
                      viewmodel.isProcessing,
                  buttonTitle: viewmodel.isProcessing ? '처리 중' : '완료',
                  backgroundColor: CustomColors.whYellow,
                  foregroundColor: CustomColors.whBlack,
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: viewmodel.isProcessing,
          child: Container(
            constraints: const BoxConstraints.expand(),
            alignment: Alignment.center,
            color: CustomColors.whDarkBlack.withAlpha(130),
            child: const CircularProgressIndicator(
              color: CustomColors.whYellow,
            ),
          ),
        ),
      ],
    );
  }
}

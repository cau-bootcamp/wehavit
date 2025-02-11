import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/constants/constants.dart';
import 'package:wehavit/dependency/dependency.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';
import 'package:wehavit/presentation/entrance/provider/edit_user_detail_view_provider.dart';
import 'package:wehavit/presentation/main/main.dart';
import 'package:wehavit/presentation/state/user_data/my_user_data_provider.dart';

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
  final nameTextEditingController = TextEditingController();
  final handleTextEditingController = TextEditingController();
  final aboutMeTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameTextEditingController.text = widget.name ?? '';
    handleTextEditingController.text = widget.handle ?? '';
    aboutMeTextEditingController.text = widget.aboutMe ?? '';
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    final viewmodel = ref.watch(editUserDataViewModelProvider);
    final userId =
        await ref.read(getMyUserIdUsecaseProvider).call().then((result) => result.fold((failure) => null, (id) => id));

    viewmodel.uid = widget.uid ?? (userId ?? '');
    viewmodel.name = widget.name ?? '';

    if (widget.isModifying) {
      loadDataFromArguments().whenComplete(() {
        setState(() {});
      });
    }
  }

  Future<void> loadDataFromArguments() async {
    final viewmodel = ref.watch(editUserDataViewModelProvider);

    viewmodel.handle = widget.handle ?? '';
    viewmodel.aboutMe = widget.aboutMe ?? '';

    await ref.read(editUserDataViewModelProvider.notifier).downloadImageToFile(widget.profileImageUrl!);
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = ref.watch(editUserDataViewModelProvider);
    final provider = ref.read(editUserDataViewModelProvider.notifier);

    UniqueKey imageKey = UniqueKey();

    nameTextEditingController.addListener(() {
      provider.setName(nameTextEditingController.text);
    });
    handleTextEditingController.addListener(() {
      provider.setHandle(handleTextEditingController.text);
    });
    aboutMeTextEditingController.addListener(() {
      provider.setAboutMe(aboutMeTextEditingController.text);
    });

    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: CustomColors.whDarkBlack,
          appBar: WehavitAppBar(
            titleLabel: widget.isModifying ? '내 정보 수정' : '회원가입',
            leadingIconString: WHIcons.back,
            leadingAction: () async {
              if (!widget.isModifying) {
                try {
                  await provider.rollbackSignUp();
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
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                          Text(
                            '이름',
                            style: context.titleSmall,
                          ),
                          Container(
                            height: 8.0,
                          ),
                          InputFormField(
                            textEditingController: nameTextEditingController,
                            descrptionHandler: (input) {
                              if (input.length > EditUserDataViewModelProvider.nameMaxLength) {
                                return (
                                  '${EditUserDataViewModelProvider.nameMinLength}자 이상 ${EditUserDataViewModelProvider.nameMaxLength}자 이하',
                                  FormFieldDescriptionType.warning
                                );
                              } else if (input.length < EditUserDataViewModelProvider.nameMinLength) {
                                return (
                                  '${EditUserDataViewModelProvider.nameMinLength}자 이상 ${EditUserDataViewModelProvider.nameMaxLength}자 이하',
                                  FormFieldDescriptionType.normal
                                );
                              } else {
                                return (
                                  '${EditUserDataViewModelProvider.nameMinLength}자 이상 ${EditUserDataViewModelProvider.nameMaxLength}자 이하',
                                  FormFieldDescriptionType.clear
                                );
                              }
                            },
                            placeholder: '친구들에게 보여줄 이름이예요',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '사용자 ID',
                            style: context.titleSmall,
                          ),
                          Container(
                            height: 8.0,
                          ),
                          InputFormField(
                            textEditingController: handleTextEditingController,
                            textInputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9a-zA-Z!@#$%^&*(),.?":{}|<>_]'),
                              ),
                            ],
                            descrptionHandler: (input) {
                              if (input.length > EditUserDataViewModelProvider.handleMaxLength) {
                                return (
                                  '${EditUserDataViewModelProvider.handleMaxLength}자 이하의 알파벳, 숫자, 특수기호',
                                  FormFieldDescriptionType.warning
                                );
                              } else if (input.length < EditUserDataViewModelProvider.handleMinLength) {
                                return (
                                  '${EditUserDataViewModelProvider.handleMaxLength}자 이하의 알파벳, 숫자, 특수기호',
                                  FormFieldDescriptionType.normal
                                );
                              } else {
                                return (
                                  '${EditUserDataViewModelProvider.handleMaxLength}자 이하의 알파벳, 숫자, 특수기호',
                                  FormFieldDescriptionType.clear
                                );
                              }
                            },
                            placeholder: '친구가 나를 찾을 때 사용하는 ID예요',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '한 줄 소개',
                            style: context.titleSmall,
                          ),
                          Container(
                            height: 8.0,
                          ),
                          InputFormField(
                            textEditingController: aboutMeTextEditingController,
                            placeholder: '나에 대해 소개해주세요',
                          ),
                        ],
                      ),
                      // Expanded(child: Container()),
                    ],
                  ),
                ),
                Consumer(
                  builder: (context, ref, _) {
                    final viewmodel = ref.watch(editUserDataViewModelProvider);

                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: WideColoredButton(
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
                                    );
                                  },
                                  (success) async {
                                    ref.invalidate(getMyUserDataProvider);
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
                        isDiminished: !((viewmodel.name.isNotEmpty & viewmodel.handle.isNotEmpty) &
                                (viewmodel.profileImage != null)) |
                            viewmodel.isProcessing,
                        buttonTitle: viewmodel.isProcessing ? '처리 중' : '완료',
                        foregroundColor: CustomColors.whBlack,
                      ),
                    );
                  },
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

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:wehavit/common/constants/app_colors.dart';

class ConfirmPostPhotoView extends StatelessWidget {
  const ConfirmPostPhotoView({
    required this.imageProviderList,
    required this.initPageIndex,
    super.key,
  });

  final List<ImageProvider> imageProviderList;
  final int initPageIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left,
            color: CustomColors.whWhite,
            size: 32.0,
          ),
        ),
      ),
      body: PhotoViewGallery.builder(
        scrollPhysics: const ClampingScrollPhysics(),
        pageController: PageController(initialPage: initPageIndex),
        backgroundDecoration: const BoxDecoration(color: Colors.black),
        itemCount: imageProviderList.length,
        loadingBuilder: (context, event) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: const Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  color: CustomColors.whYellow,
                ),
              ),
            ),
          );
        },
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: imageProviderList[index],
            initialScale: PhotoViewComputedScale.contained * 0.9,
          );
        },
      ),
    );
  }
}

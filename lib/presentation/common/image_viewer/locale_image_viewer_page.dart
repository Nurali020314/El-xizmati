import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/domain/models/image/uploadable_file.dart';
import 'package:onlinebozor/presentation/utils/xfile_mapper.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../common/gen/localization/strings.dart';

@RoutePage()
class LocaleImageViewerPage extends StatefulWidget {
  const LocaleImageViewerPage({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  final List<UploadableFile> images;
  final int initialIndex;

  @override
  _LocaleImageViewerPageState createState() => _LocaleImageViewerPageState();
}

class _LocaleImageViewerPageState extends State<LocaleImageViewerPage> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // Desired status bar color
          statusBarIconBrightness: Brightness.light // Status bar icon color
          ));
    });
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.white, // Default status bar color
          statusBarIconBrightness:
              Brightness.dark // Default status bar icon color
          ),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height;
    double width;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    var pageController = PageController(initialPage: widget.initialIndex);

    return WillPopScope(
      onWillPop: () async {
        context.router.pop(widget.images);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: PopScope(
          onPopInvoked: (didPop) {
            // if (didPop) {
            //   // context.router.pop(widget.images);
            //   AutoRouter.of(context).pop(widget.images);
            // }
          },
          child: Stack(
            children: [
              _buildImageList(pageController, height),
              _buildBackButton(context),
              _buildActionButtons(context, pageController),
            ],
          ),
        ),
      ),
    );
  }

  PhotoViewGallery _buildImageList(
    PageController pageController,
    double height,
  ) {
    return PhotoViewGallery.builder(
      reverse: false,
      onPageChanged: onPageChanged,
      pageController: pageController,
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: widget.images[index].xFile.toFileImage(),
          initialScale: PhotoViewComputedScale.contained * 1,
          heroAttributes: PhotoViewHeroAttributes(tag: widget.images[index]),
        );
      },
      itemCount: widget.images.length,
      loadingBuilder: (context, event) => Center(
        child: SizedBox(
          width: double.infinity,
          height: height / 2,
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  Positioned _buildBackButton(BuildContext context) {
    return Positioned(
      top: 48,
      left: 12,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {
              context.router.pop(widget.images);
            },
            icon: Assets.images.icArrowLeft.svg(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Positioned _buildActionButtons(
    BuildContext context,
    PageController pageController,
  ) {
    return Positioned(
      left: 16,
      bottom: 16,
      right: 16,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: CustomElevatedButton(
              buttonHeight: 32,
              text: (currentIndex == 0
                  ? Strings.commonMainPhoto
                  : Strings.commonMakeMainPhoto),
              isEnabled: currentIndex != 0,
              onPressed: () {
                setState(() {
                  var item = widget.images.removeAt(currentIndex);
                  currentIndex = -1;
                  widget.images.insert(0, item);
                  pageController.jumpToPage(0);
                });
              },
              textColor: Colors.black,
              backgroundColor: Colors.white,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: CustomElevatedButton(
              buttonHeight: 32,
              text: Strings.commonDelete,
              onPressed: () {
                setState(() {
                  widget.images.removeAt(currentIndex);
                  if (widget.images.isEmpty) {
                    context.router.pop(widget.images);
                  }
                });
              },
              textColor: Colors.black,
              backgroundColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}

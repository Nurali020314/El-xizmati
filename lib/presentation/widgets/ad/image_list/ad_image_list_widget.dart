import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/assets/assets.gen.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:flutter/services.dart';
import 'package:El_xizmati/domain/models/image/uploadable_file.dart';
import 'package:El_xizmati/presentation/support/extensions/platform_sizes.dart';
import 'package:El_xizmati/presentation/widgets/action/action_list_item.dart';
import 'package:El_xizmati/presentation/widgets/ad/image_list/ad_image_list_add_widget.dart';
import 'package:El_xizmati/presentation/widgets/ad/image_list/ad_image_list_image_widget.dart';
import 'package:El_xizmati/presentation/widgets/bottom_sheet/bottom_sheet_title.dart';
import 'package:El_xizmati/presentation/widgets/form_field/label_text_field.dart';

class AdImageListWidget extends StatelessWidget {
  const AdImageListWidget({
    super.key,
    required this.imagePaths,
    required this.maxCount,
    required this.onTakePhotoClicked,
    required this.onPickImageClicked,
    required this.onImageClicked,
    required this.onRemoveClicked,
    required this.onReorder,
    this.autoValidateMode,
    this.validator,
  });

  final List<UploadableFile> imagePaths;
  final int maxCount;
  final Function() onTakePhotoClicked;
  final Function() onPickImageClicked;
  final Function(int index) onImageClicked;
  final Function(UploadableFile file) onRemoveClicked;
  final Function(int oldIndex, int newIndex) onReorder;
  final AutovalidateMode? autoValidateMode;
  final String? Function(int count)? validator;

  @override
  Widget build(BuildContext context) {
    return FormField(
      validator: (v) {
        return validator != null ? validator!(imagePaths.length) : null;
      },
      builder: (state) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          margin: EdgeInsets.only(top: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: LabelTextField(Strings.imageListTitle),
              ),
              SizedBox(height: 8),
              SizedBox(
                height: 82,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      SizedBox(width: 16),
                      AdImageListAddWidget(
                        key: ValueKey(-1),
                        index: -1,
                        onAddClicked: () {
                          if (imagePaths.length < maxCount) {
                            _showPickerTypeBottomSheet(context);
                          } else {
                            _showMaxCountError(context);
                          }
                        },
                      ),
                      ReorderableListView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(left: 6, right: 10),
                        proxyDecorator: (
                          Widget child,
                          int index,
                          Animation<double> animation,
                        ) {
                          return Material(
                            elevation: 0,
                            animationDuration: Duration.zero,
                            color: Colors.transparent,
                            child: child,
                          );
                        },
                        onReorderStart: (index) {
                          HapticFeedback.lightImpact();
                        },
                        onReorder: (int oldIndex, int newIndex) {
                          onReorder(oldIndex, newIndex);
                          HapticFeedback.lightImpact();
                        },
                        children: imagePaths
                            .mapIndexed(
                              (index, element) => Padding(
                                key: ValueKey(element),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: AdImageListImageWidget(
                                  key: ValueKey(element),
                                  index: index,
                                  uploadableFile: element,
                                  onImageClicked: () {
                                    onImageClicked(index);
                                  },
                                  onRemoveClicked: (file) {
                                    onRemoveClicked(file);
                                  },
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Strings.imageListMainImage.w(400).s(10),
              ),
              if (state.hasError) SizedBox(height: 8),
              if (state.hasError)
                Row(
                  children: [
                    SizedBox(width: 16),
                    (state.errorText!).s(12).c(Colors.red).copyWith(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  void _showPickerTypeBottomSheet(BuildContext context) {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Material(
          child: Container(
            decoration: BoxDecoration(
              color: context.bottomSheetColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            // padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                BottomSheetTitle(
                  title: Strings.addImageActionsTitle,
                  onCloseClicked: () {
                    context.router.pop();
                  },
                ),
                SizedBox(height: 16),
                ActionListItem(
                  item: "",
                  title: Strings.imageListAddTakePhoto,
                  icon: Assets.images.icAddImageCamera,
                  onClicked: (item) {
                    onTakePhotoClicked();
                    Navigator.pop(context);
                  },
                ),
                ActionListItem(
                  item: "",
                  title: Strings.imageListAddPickImage,
                  icon: Assets.images.icAddImageGallery,
                  onClicked: (item) {
                    onPickImageClicked();
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: defaultBottomPadding),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showMaxCountError(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to close the dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          // title: Text('Alert!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Strings.imageListMaxCountError(max_count: maxCount).s(14),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Strings.closeTitle.s(14),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';

import '../../../../../../common/gen/assets/assets.gen.dart';
import '../../../../common/vibrator/vibrator_extension.dart';
import '../../../../common/widgets/app_bar/common_app_bar.dart';
import '../../../../common/widgets/common/common_button.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class CreateAdChooserPage extends BasePage<CreateAdChooserCubit,
    CreateAdChooserBuildable, CreateAdChooserListenable> {
  const CreateAdChooserPage({super.key});

  @override
  Widget builder(BuildContext context, CreateAdChooserBuildable state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.5,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: state.isLogin
              ? [
                  _buildSaleBlock(context),
                  _buildBuyBlock(context),
                ]
              : [
                  _buildDirectToRegister(context),
                ],
        ),
      ),
    );
  }

  Widget _buildBuyBlock(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFE5E9F3), width: 1),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Assets.images.pngImages.buy.image(height: 86, width: 86),
            Strings.adCreationStartBuyTitle
                .w(800)
                .s(18)
                .c(context.colors.textPrimary),
            SizedBox(height: 16),
            Strings.adCreationStartBuyDesc
                .w(500)
                .s(14)
                .c(context.colors.textSecondary)
                .copyWith(textAlign: TextAlign.center),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CommonButton(
                    color: context.colors.buttonPrimary,
                    type: ButtonType.elevated,
                    onPressed: () {
                      context.router.push(CreateProductOrderRoute());
                    },
                    child: Strings.adCreationStartBuyProduct
                        .s(13)
                        .w(400)
                        .c(Colors.white),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: CommonButton(
                    color: context.colors.buttonPrimary,
                    type: ButtonType.elevated,
                    onPressed: () {
                      context.router.push(CreateServiceOrderRoute());
                    },
                    child: Strings.adCreationStartBuyService
                        .s(13)
                        .w(400)
                        .c(Colors.white),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaleBlock(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFE5E9F3), width: 1),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.images.pngImages.sell.image(height: 86, width: 86),
            Strings.adCreationStartSaleTitle
                .w(800)
                .s(18)
                .c(context.colors.textPrimary),
            SizedBox(height: 16),
            SafeArea(
              child: Strings.adCreationStartSaleDesc
                  .w(500)
                  .s(14)
                  .c(context.colors.textSecondary)
                  .copyWith(textAlign: TextAlign.center),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CommonButton(
                    color: context.colors.buttonPrimary,
                    type: ButtonType.elevated,
                    onPressed: () {
                      context.router.push(CreateProductAdRoute());
                    },
                    child: Strings.adCreationStartSaleProduct
                        .s(13)
                        .w(400)
                        .c(Colors.white)
                        .copyWith(textAlign: TextAlign.center),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: CommonButton(
                    color: context.colors.buttonPrimary,
                    type: ButtonType.elevated,
                    onPressed: () {
                      context.router.push(CreateServiceAdRoute());
                    },
                    child: Strings.adCreationStartSaleService
                        .s(13)
                        .w(400)
                        .c(Colors.white)
                        .copyWith(textAlign: TextAlign.center),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDirectToRegister(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 36),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(height: 170),
        Assets.images.pngImages.adEmpty.image(),
        SizedBox(height: 48),
        Strings.authRecommentTitle.w(500).s(20).c(Color(0xFF41455E)).copyWith(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start),
        SizedBox(height: 12),
        Strings.authRecommentDesc.w(400).s(18).c(Color(0xFF41455E)).copyWith(
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
class CreateAdChooserPage extends BasePage<PageCubit, PageState, PageEvent> {
  Widget onWidgetBuild(BuildContext context, PageState state) {
      appBar: CommonAppBar("", () => context.router.pop()),
        SizedBox(height: 130),
        SizedBox(
            width: double.maxFinite,
            child: CommonButton(
              type: ButtonType.elevated,
              color: context.colors.buttonPrimary,
              onPressed: () {
                context.router.push(AuthStartRoute());
                vibrateAsHapticFeedback();
              },
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 10),
                    Strings.authRecommentAction.w(500).s(14).c(Colors.white)
                  ]),
            ))
      ]),
    );
  }
}

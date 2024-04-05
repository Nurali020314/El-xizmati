import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/app_bar/empty_app_bar.dart';
import 'package:onlinebozor/common/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/domain/models/ad/ad_transaction_type.dart';

import '../../../../../../common/gen/assets/assets.gen.dart';
import '../../../../common/vibrator/vibrator_extension.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class CreateAdChooserPage extends BasePage<PageCubit, PageState, PageEvent> {
  const CreateAdChooserPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      appBar: EmptyAppBar(),
      backgroundColor: state.isLogin ? Color(0xFFF2F4FB) : Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: state.isLogin
              ? [
                  _buildAdCreationBlock(context),
                  _buildRequestCreationBlock(context),
                ]
              : [
                  _buildAuthBlock(context),
                ],
        ),
      ),
    );
  }

  Widget _buildAdCreationBlock(BuildContext context) {
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
                  child: CustomElevatedButton(
                    text: Strings.adCreationStartSaleProduct,
                    onPressed: () {
                      context.router.push(CreateProductAdRoute());
                    },
                    buttonHeight: 36,
                    textSize: 12,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: CustomElevatedButton(
                    text: Strings.adCreationStartSaleService,
                    onPressed: () {
                      context.router.push(CreateServiceAdRoute());
                    },
                    buttonHeight: 36,
                    textSize: 12,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestCreationBlock(BuildContext context) {
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
                  child: CustomElevatedButton(
                    text: Strings.adCreationStartBuyProduct,
                    onPressed: () {
                      context.router.push(CreateRequestAdRoute(
                        adTransactionType: AdTransactionType.BUY,
                      ));
                    },
                    buttonHeight: 36,
                    textSize: 12,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: CustomElevatedButton(
                    text: Strings.adCreationStartBuyService,
                    onPressed: () {
                      context.router.push(CreateRequestAdRoute(
                        adTransactionType: AdTransactionType.BUY_SERVICE,
                      ));
                    },
                    buttonHeight: 36,
                    textSize: 12,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthBlock(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 36),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 170),
            Assets.images.pngImages.adEmpty.image(),
            SizedBox(height: 48),
            Strings.authRecommentTitle
                .w(500)
                .s(20)
                .c(Color(0xFF41455E))
                .copyWith(textAlign: TextAlign.center),
            SizedBox(height: 20),
            Strings.authRecommentDesc
                .w(500)
                .s(16)
                .c(Color(0xFF41455E))
                .copyWith(textAlign: TextAlign.center),
            SizedBox(height: 120),
            SizedBox(
              width: double.maxFinite,
              child: CustomElevatedButton(
                text: Strings.authRecommentAction,
                onPressed: () {
                  context.router.push(AuthStartRoute());
                  vibrateAsHapticFeedback();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

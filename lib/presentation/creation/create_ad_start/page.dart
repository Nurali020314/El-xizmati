import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';

import '../../../common/core/base_page.dart';
import '../../../common/gen/assets/assets.gen.dart';
import '../../../common/widgets/app_bar/common_app_bar.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class CreateAdStartPage
    extends BasePage<PageCubit, PageState, PageEvent> {
  const CreateAdStartPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      appBar: CommonAppBar(Strings.adCreateTitle, () => context.router.pop()),
      body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildProductWidget(context),
            _buildServiceWidget(context)
          ]),
    );
  }

  Expanded _buildProductWidget(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          context.router.push(CreateProductAdRoute());
        },
        child: Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Color(0xFFE5E9F3), width: 1)),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.images.pngImages.sell.image(),
                SizedBox(height: 16),
                "Sotaman".w(500).s(16).c(context.colors.textPrimary)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildServiceWidget(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          context.router.push(CreateServiceAdRoute());
        },
        child: Container(
          margin: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Color(0xFFE5E9F3), width: 1),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.images.pngImages.buy.image(),
                SizedBox(height: 16),
                "Solib olaman".w(500).s(16).c(context.colors.textPrimary)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
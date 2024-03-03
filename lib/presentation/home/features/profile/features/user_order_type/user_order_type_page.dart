import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/app_bar/default_app_bar.dart';

import '../../../../../../common/colors/static_colors.dart';
import '../../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../../domain/models/order/order_type.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class UserOrderTypePage extends BasePage<PageCubit, PageState, PageEvent> {
  const UserOrderTypePage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      appBar: DefaultAppBar("", () => context.router.pop()),
      backgroundColor: StaticColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCreateProductRequest(context),
            SizedBox(height: 16),
            _buildCreateServiceRequest(context)
          ],
        ),
      ),
    );
  }

  Widget _buildCreateProductRequest(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.router.push(UserOrderListRoute(orderType: OrderType.buy));
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
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
                    Assets.images.pngImages.sell.image(width: 116, height: 116),
                    SizedBox(height: 16),
                    "Sotaman".w(500).s(16).c(context.colors.textPrimary)
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCreateServiceRequest(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.router.push(UserOrderListRoute(orderType: OrderType.sell));
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
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
                    Assets.images.pngImages.buy.image(width: 116, height: 116),
                    SizedBox(height: 16),
                    "Sotib olaman".w(500).s(16).c(context.colors.textPrimary)
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
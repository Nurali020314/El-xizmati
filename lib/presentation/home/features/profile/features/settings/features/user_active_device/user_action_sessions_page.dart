import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/widgets/button/common_button.dart';
import 'package:onlinebozor/common/widgets/device/active_device_widgets.dart';
import 'package:onlinebozor/data/responses/device/active_device_response.dart';
import 'package:onlinebozor/presentation/home/features/profile/features/settings/features/user_active_device/cubit/page_cubit.dart';

import '../../../../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../../../../common/widgets/device/active_device_shimmer.dart';

@RoutePage()
class UserActiveSessionsPage extends BasePage<PageCubit, PageState, PageEvent> {
  const UserActiveSessionsPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    double width;
    double height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Strings.settingsActiveDevices
              .w(500)
              .s(14)
              .c(context.colors.textPrimary),
          centerTitle: true,
          elevation: 0.5,
          leading: IconButton(
            icon: Assets.images.icArrowLeft.svg(),
            onPressed: () => context.router.pop(),
          ),
        ),
        body: PagedGridView<int, ActiveDeviceResponse>(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            pagingController: state.controller!,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: width / height,
              crossAxisSpacing: 16,
              mainAxisSpacing: 0,
              mainAxisExtent: 145,
              crossAxisCount: 1,
            ),
            builderDelegate: PagedChildBuilderDelegate<ActiveDeviceResponse>(
              firstPageErrorIndicatorBuilder: (_) {
                return SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: Center(
                        child: Column(
                      children: [
                        Strings.loadingStateError
                            .w(400)
                            .s(14)
                            .c(context.colors.textPrimary),
                        SizedBox(height: 12),
                        CommonButton(
                            onPressed: () {},
                            type: ButtonType.elevated,
                            text: Strings.loadingStateRetry.w(400).s(15))
                      ],
                    )));
              },
              firstPageProgressIndicatorBuilder: (_) {
                return SingleChildScrollView(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 14,
                    itemBuilder: (BuildContext context, int index) {
                      return ActiveDeviceShimmer();
                    },
                  ),
                );
              },
              noItemsFoundIndicatorBuilder: (_) {
                return Center(child: Text(Strings.loadingStateNoItemFound));
              },
              newPageProgressIndicatorBuilder: (_) {
                return SizedBox(
                  height: 60,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
                );
              },
              newPageErrorIndicatorBuilder: (_) {
                return SizedBox(
                  height: 60,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
                );
              },
              transitionDuration: Duration(milliseconds: 100),
              itemBuilder: (context, item, index) {
                return ActiveDeviceWidget(
                    invoke: (response) {
                      cubit(context).removeActiveDevice(response);
                    },
                    response: item);
              },
            )));
  }
}
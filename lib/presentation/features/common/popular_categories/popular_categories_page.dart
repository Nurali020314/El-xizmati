import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/data/datasource/network/responses/category/popular_category/popular_category_response.dart';
import 'package:onlinebozor/domain/models/ad/ad_list_type.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:onlinebozor/presentation/widgets/category/popular_category_vertical.dart';
import 'package:onlinebozor/presentation/widgets/category/popular_category_vertical_shimmer.dart';
import 'package:onlinebozor/presentation/widgets/elevation/elevation_widget.dart';
import 'package:onlinebozor/presentation/widgets/loading/default_error_widget.dart';

import 'popular_categories_cubit.dart';

@RoutePage()
class PopularCategoriesPage extends BasePage<PopularCategoriesCubit,
    PopularCategoriesState,
    PopularCategoriesEvent> {
  const PopularCategoriesPage(this.title, {super.key});

  final String? title;

  @override
  Widget onWidgetBuild(BuildContext context, PopularCategoriesState state) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: title ?? "",
        titleTextColor: context.textPrimary,
        backgroundColor: context.backgroundGreyColor,
        onBackPressed: () => context.router.pop(),
      ),
      backgroundColor: context.backgroundGreyColor,
      body: state.controller == null
          ? SizedBox()
          : SizedBox(
        child: PagedListView<int, PopularCategory>(
          shrinkWrap: true,
          addAutomaticKeepAlives: false,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 10),
          pagingController: state.controller!,
          builderDelegate: PagedChildBuilderDelegate<PopularCategory>(
            firstPageErrorIndicatorBuilder: (_) {
              return DefaultErrorWidget(
                isFullScreen: true,
                onRetryClicked: () =>
                    cubit(context).states.controller?.refresh(),
              );
            },
            firstPageProgressIndicatorBuilder: (_) {
              return SingleChildScrollView(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 7,
                  itemBuilder: (BuildContext context, int index) {
                    return PopularCategoryVerticalShimmer();
                  },
                ),
              );
            },
            noItemsFoundIndicatorBuilder: (_) {
              return Center(child: Strings.commonEmptyMessage.w(400));
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
              return DefaultErrorWidget(
                isFullScreen: false,
                onRetryClicked: () {
                  cubit(context).states.controller?.refresh();
                },
              );
            },
            transitionDuration: Duration(milliseconds: 100),
            itemBuilder: (context, item, index) =>
                ElevationWidget(
                  topLeftRadius: 6,
                  topRightRadius: 6,
                  bottomLeftRadius: 6,
                  bottomRightRadius: 6,
                  shadowSpreadRadius: 1.5,
                  leftMargin: 16,
                  topMargin: 6,
                  rightMargin: 16,
                  bottomMargin: 6,
                  child: PopularCategoryVertical(
                    category: item,
                    onItemClicked: (value) {
                      context.router.push(
                        AdListRoute(
                          adListType: AdListType.homeList,
                          keyWord: value.key_word,
                          title: value.name,
                          sellerTin: null,
                        ),
                      );
                    },
                  ),
                ),
          ),
        ),
      ),
    );
  }
}

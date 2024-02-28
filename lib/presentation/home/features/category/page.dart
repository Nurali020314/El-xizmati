import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/app_bar/common_search_bar.dart';
import 'package:onlinebozor/common/widgets/category/category_widget.dart';
import 'package:onlinebozor/common/widgets/loading/loader_state_widget.dart';

import '../../../../data/responses/category/category/category_response.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class CategoryPage extends BasePage<PageCubit, PageState, PageEvent> {
  const CategoryPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      appBar: CommonSearchBar(
        onSearchClicked: () => context.router.push(SearchRoute()),
        onMicrophoneClicked: () {},
        onFavoriteClicked: () => context.router.push(FavoritesRoute()),
        onNotificationClicked: () => context.router.push(NotificationRoute()),
      ),
      backgroundColor: Color(0xFFF2F4FB),
      body: LoaderStateWidget(
        isFullScreen: true,
        loadingState: state.loadState,
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: state.items.length,
          itemBuilder: (context, index) {
            return AppCategoryWidget(
              onClicked: (CategoryResponse categoryResponse) {
                context.router.push(
                  SubCategoryRoute(
                      subCategoryId: categoryResponse.id,
                      title: categoryResponse.name ?? ""),
                );
              },
              category: state.items[index],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(indent: 54, color: Color(0xFFE5E9F3));
          },
        ),
      ),
    );
  }
}
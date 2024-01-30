import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/ad/horizontal_ad_list_widget.dart';
import 'package:onlinebozor/common/widgets/app_bar/common_active_search_bar.dart';
import 'package:onlinebozor/common/widgets/dashboard/app_diverder.dart';
import 'package:onlinebozor/common/widgets/dashboard/see_all_widget.dart';

import '../../../common/core/base_page.dart';
import '../../../common/widgets/ad/vertical_ad_widget.dart';
import '../../../common/widgets/common/common_button.dart';
import '../../../common/widgets/loading/loader_state_widget.dart';
import '../../../domain/models/ad/ad.dart';
import '../../../domain/models/ad/ad_list_type.dart';
import '../../../domain/models/ad/ad_type.dart';
import 'cubit/ad_list_by_type_cubit.dart';

@RoutePage()
class AdListByTypePage extends BasePage<AdListByTypeCubit,
    AdListByTypeBuildable, AdListByTypeListenable> {
  const AdListByTypePage(this.adType, {super.key});

  final AdType adType;

  @override
  void init(BuildContext context) {
    context.read<AdListByTypeCubit>().setAdType(adType);
  }

  @override
  void listener(BuildContext context, AdListByTypeListenable state) {
    switch (state.effect) {
      case AdsListByTypeEffect.success:
        () {};
      case AdsListByTypeEffect.navigationToAuthStart:
        context.router.push(AuthStartRoute());
    }
  }

  @override
  Widget builder(BuildContext context, AdListByTypeBuildable state) {
    double width;
    double height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Center(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: CommonActiveSearchBar(
                listener: () => context.router.pop(),
                listenerSearch: () => context.router.push(SearchRoute()),
                listenerNotification: () =>
                    context.router.push(NotificationRoute())),
            body: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                    child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(right: 16, left: 16, top: 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: switch (adType) {
                            AdType.product => Strings.favoriteProductTitle
                                .w(700)
                                .s(16)
                                .c(context.colors.textPrimary),
                            AdType.service => Strings.favoriteServiceTitle
                                .w(700)
                                .s(16)
                                .c(context.colors.textPrimary),
                          },
                        )),
                    SeeAllWidget(
                        listener: () {
                          context.router.push(AdListRoute(
                              adType: state.adType,
                              adListType: AdListType.cheaperAdsByAdType,
                              keyWord: '',
                              title: "eng arzonlari"));
                        },
                        title: "eng arzonlari"),
                    LoaderStateWidget(
                        isFullScreen: false,
                        loadingState: state.cheapAdsState,
                        child: HorizontalAdListWidget(
                          ads: state.cheapAds,
                          onItemClicked: (Ad result) {
                            context.router.push(AdDetailRoute(adId: result.id));
                          },
                          onFavoriteClicked: (Ad result) => context
                              .read<AdListByTypeCubit>()
                              .cheapAdsAddFavorite(result),
                        )),
                    SizedBox(height: 6),
                    AppDivider(height: 3),
                    SeeAllWidget(
                        listener: () {
                          context.router.push(AdListRoute(
                            adType: state.adType,
                            adListType: AdListType.popularAdsByAdType,
                            keyWord: '',
                            title: Strings.adCollectivePopular,
                          ));
                        },
                        title: Strings.adCollectivePopular),
                    SizedBox(height: 6),
                    LoaderStateWidget(
                        isFullScreen: false,
                        loadingState: state.popularAdsState,
                        child: HorizontalAdListWidget(
                          ads: state.popularAds,
                          onItemClicked: (Ad result) {
                            context.router.push(AdDetailRoute(adId: result.id));
                          },
                          onFavoriteClicked: (Ad result) => context
                              .read<AdListByTypeCubit>()
                              .popularAdsAddFavorite(result),
                        )),
                    SizedBox(height: 6),
                    AppDivider(height: 3),
                    SizedBox(height: 24)
                  ],
                )),
                state.adsPagingController == null
                    ? SizedBox()
                    : PagedSliverGrid<int, Ad>(
                        pagingController: state.adsPagingController!,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: width / height,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 24,
                          mainAxisExtent: 315,
                          crossAxisCount: 2,
                        ),
                        builderDelegate: PagedChildBuilderDelegate<Ad>(
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
                                        child: Strings.loadingStateRetry
                                            .w(400)
                                            .s(15))
                                  ],
                                )));
                          },
                          firstPageProgressIndicatorBuilder: (_) {
                            return SizedBox(
                              height: 60,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                ),
                              ),
                            );
                          },
                          noItemsFoundIndicatorBuilder: (_) {
                            return Center(
                                child: Text(Strings.loadingStateNoItemFound));
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
                            if (index % 2 == 1) {
                              return Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: VerticalAdWidget(
                                  ad: item,
                                  invokeFavorite: (value) => context
                                      .read<AdListByTypeCubit>()
                                      .addFavorite(value),
                                  invoke: (value) => context.router
                                      .push(AdDetailRoute(adId: value.id)),
                                ),
                              );
                            } else {
                              return Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: VerticalAdWidget(
                                  ad: item,
                                  invokeFavorite: (value) => context
                                      .read<AdListByTypeCubit>()
                                      .addFavorite(value),
                                  invoke: (value) => context.router
                                      .push(AdDetailRoute(adId: value.id)),
                                ),
                              );
                            }
                          },
                        ))
              ],
            )));
  }
}
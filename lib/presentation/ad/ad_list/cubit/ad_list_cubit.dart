import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

import '../../../../common/enum/ad_enum.dart';
import '../../../../common/enum/loading_enum.dart';
import '../../../../data/model/ads/ad/ad_response.dart';
import '../../../../domain/repository/ad_repository.dart';

part 'ad_list_cubit.freezed.dart';
part 'ad_list_state.dart';

@injectable
class AdListCubit extends BaseCubit<AdListBuildable, AdListListenable> {
  AdListCubit(this.adRepository) : super(AdListBuildable()) {
    getController();
  }

  void initiallyDate(String? keyWord, AdListType adListType) {
    build((buildable) => buildable.copyWith(keyWord: keyWord ?? ""));
  }

  static const _pageSize = 20;
  final AdRepository adRepository;

  Future<void> getController() async {
    try {
      final controller =
          buildable.adsPagingController ?? getAdsController(status: 1);
      build((buildable) => buildable.copyWith(adsPagingController: controller));
    } catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      log.i(buildable.adsPagingController);
      // build((buildable) => buildable.copyWith(loading: false));
    }
  }

  PagingController<int, AdResponse> getAdsController({
    required int status,
  }) {
    final adController = PagingController<int, AdResponse>(
      firstPageKey: 1,
    );
    log.i(buildable.adsPagingController);

    adController.addPageRequestListener(
      (pageKey) async {
        final adsList =
            await adRepository.getAds(pageKey, _pageSize, buildable.keyWord);
        if (adsList.length <= 19) {
          adController.appendLastPage(adsList);
          log.i(buildable.adsPagingController);
          return;
        }
        adController.appendPage(adsList, pageKey + 1);
        log.i(buildable.adsPagingController);
      },
    );
    return adController;
  }
}

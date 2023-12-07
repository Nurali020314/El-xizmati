import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/core/base_cubit.dart';
import '../../../../common/enum/enums.dart';
import '../../../../data/responses/category/popular_category/popular_category_response.dart';
import '../../../../domain/repositories/common_repository.dart';

part 'popular_categories_cubit.freezed.dart';
part 'popular_categories_state.dart';

@injectable
class PopularCategoriesCubit extends BaseCubit<PopularCategoriesBuildable, PopularCategoriesListenable> {
  PopularCategoriesCubit(this._repository)
      : super(const PopularCategoriesBuildable()) {
    getController();
  }

  final CommonRepository _repository;

  Future<void> getController() async {
    try {
      final controller =
          buildable.categoriesPagingController ?? getAdsController(status: 1);
      build((buildable) =>
          buildable.copyWith(categoriesPagingController: controller));
    } on DioException catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      log.i(buildable.categoriesPagingController);
      // build((buildable) => buildable.copyWith(loading: false));
    }
  }

  PagingController<int, PopularCategoryResponse> getAdsController({
    required int status,
  }) {
    final adController = PagingController<int, PopularCategoryResponse>(
      firstPageKey: 1,
    );
    log.i(buildable.categoriesPagingController);

    adController.addPageRequestListener(
          (pageKey) async {
        final adsList = await _repository.getPopularCategories(pageKey, 20);
        if (adsList.length <= 19) {
          adController.appendLastPage(adsList);
          log.i(buildable.categoriesPagingController);
          return;
        }
        adController.appendPage(adsList, pageKey + 1);
        log.i(buildable.categoriesPagingController);
      },
    );
    return adController;
  }
}

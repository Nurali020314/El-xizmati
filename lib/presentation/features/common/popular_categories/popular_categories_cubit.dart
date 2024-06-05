import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/data/datasource/network/responses/category/popular_category/popular_category_response.dart';
import 'package:onlinebozor/data/repositories/common_repository.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'popular_categories_cubit.freezed.dart';
part 'popular_categories_state.dart';

@injectable
class PopularCategoriesCubit
    extends BaseCubit<PopularCategoriesState, PopularCategoriesEvent> {
  PopularCategoriesCubit(this._commonRepository)
      : super(const PopularCategoriesState()) {
    getController();
  }

  final CommonRepository _commonRepository;

  Future<void> getController() async {
    try {
      final controller = states.controller ?? getPagingController(status: 1);
      updateState((state) => state.copyWith(controller: controller));
    } catch (e, stackTrace) {
      logger.e(e.toString(), error: e, stackTrace: stackTrace);
      stateMessageManager.showErrorSnackBar(e.toString());
    } finally {
      logger.i(states.controller);
      // build((state) => state.copyWith(loading: false));
    }
  }

  PagingController<int, PopularCategory> getPagingController({
    required int status,
  }) {
    final adController = PagingController<int, PopularCategory>(
      firstPageKey: 1,
    );
    logger.i(states.controller);

    adController.addPageRequestListener(
      (pageKey) async {
        final adsList =
            await _commonRepository.getPopularCategories(pageKey, 20);
        if (adsList.length <= 19) {
          adController.appendLastPage(adsList);
          logger.i(states.controller);
          return;
        }
        adController.appendPage(adsList, pageKey + 1);
        logger.i(states.controller);
      },
    );
    return adController;
  }
}
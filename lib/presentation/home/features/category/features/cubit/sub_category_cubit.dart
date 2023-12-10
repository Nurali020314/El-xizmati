import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';

import '../../../../../../common/enum/enums.dart';
import '../../../../../../data/responses/category/category/category_response.dart';
import '../../../../../../domain/repositories/common_repository.dart';

part 'sub_category_cubit.freezed.dart';

part 'sub_category_state.dart';

@Injectable()
class SubCategoryCubit
    extends BaseCubit<SubCategoryBuildable, SubCategoryListenable> {
  SubCategoryCubit(this._repository) : super(SubCategoryBuildable());

  final CommonRepository _repository;

  Future<void> getCategories(int subCategoryId) async {
    try {
      final categories = await _repository.getCategories();
      final result = categories
          .where((element) => element.parent_id == subCategoryId)
          .toList();
      log.i(categories.toString());
      build((buildable) => buildable.copyWith(
          categories: result, categoriesState: AppLoadingState.success));
    } on DioException catch (exception) {
      log.e(exception.toString());
      display.error(exception.toString());
      build((buildable) =>
          buildable.copyWith(categoriesState: AppLoadingState.error));
    }
  }
}
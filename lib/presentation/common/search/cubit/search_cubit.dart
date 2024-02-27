import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/common/enum/enums.dart';
import '../../../../data/responses/search/search_response.dart';
import '../../../../data/repositories/ad_repository.dart';

part 'search_cubit.freezed.dart';
part 'search_state.dart';

@injectable
class SearchCubit extends BaseCubit<SearchBuildable, SearchListenable> {
  SearchCubit(this._repository) : super(SearchBuildable());

  final AdRepository _repository;

  Future<void> getSearchResult(String request) async {
    try {
      updateState((buildable) =>
          buildable.copyWith(appLoadingState: LoadingState.loading));
      final result = await _repository.getSearch(request);
      if (result.isNotEmpty) {
        updateState((buildable) => buildable.copyWith(
            searchResult: result, appLoadingState: LoadingState.success));
      } else {
        updateState((buildable) =>
            buildable.copyWith(appLoadingState: LoadingState.empty));
      }
    } on DioException catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }
}

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/data/responses/address/user_address_response.dart';

import '../../../../../../common/enum/enums.dart';
import '../../../../data/repositories/user_address_repository.dart';

part 'page_cubit.freezed.dart';
part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this.repository) : super(const PageState()) {
    getItems();
  }

  final UserAddressRepository repository;

  Future<void> getItems() async {
    updateState((state) => state.copyWith(loadState: LoadingState.loading));
    try {
      final items = await repository.getUserAddresses();
      var isEmpty = items.isEmpty;
      updateState((state) => state.copyWith(
            loadState: isEmpty ? LoadingState.empty : LoadingState.success,
            items: items,
          ));
    } catch (exception) {
      log.e(exception.toString());
      updateState((state) => state.copyWith(loadState: LoadingState.error));
    }
  }
}

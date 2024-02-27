import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/data/repositories/ad_creation_repository.dart';
import 'package:onlinebozor/data/responses/address/user_address_response.dart';

import '../../../../../../common/enum/enums.dart';

part 'selection_user_warehouse_cubit.freezed.dart';

part 'selection_user_warehouse_state.dart';

@Injectable()
class SelectionUserWarehouseCubit extends BaseCubit<
    SelectionUserWarehouseBuildable, SelectionUserWarehouseListenable> {
  SelectionUserWarehouseCubit(this._repository)
      : super(SelectionUserWarehouseBuildable()) {
    getItems();
  }

  final AdCreationRepository _repository;

  Future<void> getItems() async {
    try {
      final warehouses = await _repository.getWarehousesForCreationAd();
      log.i(warehouses.toString());
      updateState(
        (buildable) => buildable.copyWith(
          items: warehouses,
          itemsLoadState: LoadingState.success,
        ),
      );
    } on DioException catch (exception) {
      log.e(exception.toString());
      updateState(
        (buildable) => buildable.copyWith(
          itemsLoadState: LoadingState.error,
        ),
      );
    }
  }

  void setInitialSelectedItems(List<UserAddressResponse>? warehouses) {
    try {
      if (warehouses != null) {
        List<UserAddressResponse> updatedSelectedItems = [];
        updatedSelectedItems.addAll(warehouses);
        updateState(
          (buildable) => buildable.copyWith(
            selectedItems: updatedSelectedItems,
          ),
        );
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  void updateSelectedItems(UserAddressResponse warehouse) {
    try {
      var updatedSelectedItems =
          List<UserAddressResponse>.from(currentState.selectedItems);

      if (currentState.selectedItems.contains(warehouse)) {
        updatedSelectedItems.remove(warehouse);
      } else {
        updatedSelectedItems.add(warehouse);
      }

      updateState(
        (buildable) => buildable.copyWith(
          selectedItems: updatedSelectedItems,
        ),
      );
    } catch (e) {
      log.e(e.toString());
    }
  }
}

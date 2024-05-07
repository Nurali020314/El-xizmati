import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/data/repositories/user_order_repository.dart';
import 'package:onlinebozor/data/datasource/network/responses/user_order/user_order_response.dart';
import 'package:onlinebozor/domain/models/order/order_cancel_reason.dart';
import 'package:onlinebozor/domain/models/order/user_order_status.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this._userOrderRepository) : super(PageState());

  final UserOrderRepository _userOrderRepository;

  void setInitialParams(UserOrder userOrder) {
    updateState((state) => state.copyWith(
          userOrder: userOrder,
          reasons: OrderCancelReason.values,
        ));
  }

  Future<void> cancelOrder() async {
    updateState((state) => state.copyWith(loadState: LoadingState.loading));

    try {
      await _userOrderRepository.cancelOrder(
        orderId: states.userOrder!.orderId,
        reason: states.selectedReason,
        comment: states.cancelComment,
      );
      updateState((state) => state.copyWith(
            loadState: LoadingState.success,
            userOrder: state.userOrder?.copyWith(
              status: UserOrderStatus.CANCELED.name,
              cancelNote: state.isCommentEnabled
                  ? state.cancelComment
                  : state.selectedReason.name,
            ),
          ));

      logger.w("cancelOrder success");
      emitEvent(PageEvent(PageEventType.onBackAfterCancel));
    } catch (e) {
      logger.w("cancelOrder error = $e");
      updateState((state) => state.copyWith(loadState: LoadingState.error));
    }
  }

  void setSelectedReason(OrderCancelReason reason) {
    updateState((state) => state.copyWith(
          selectedReason: reason,
          isCommentEnabled: reason == OrderCancelReason.OTHER_REASON,
        ));
  }

  void setEnteredComment(String comment) {
    updateState((state) => state.copyWith(cancelComment: comment));
  }
}

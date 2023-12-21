import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../common/core/base_cubit_new.dart';
import '../../../../../../../../../common/enum/enums.dart';
import '../../../../../../../../../data/responses/user_order/user_order_response.dart';
import '../../../../../../../../../domain/util.dart';

part 'user_pending_orders_cubit.freezed.dart';
part 'user_pending_orders_state.dart';

@injectable
class UserPendingOrdersCubit
    extends BaseCubit<UserPendingOrdersBuildable, UserPendingOrdersListenable> {
  UserPendingOrdersCubit() : super(const UserPendingOrdersBuildable());

  void setInitialOrderType(OrderType orderType) {
    build((buildable) => buildable.copyWith(orderType: orderType));
  }
}

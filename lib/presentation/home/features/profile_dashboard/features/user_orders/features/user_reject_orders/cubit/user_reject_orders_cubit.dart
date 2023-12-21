import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';

import '../../../../../../../../../common/enum/enums.dart';
import '../../../../../../../../../data/responses/user_order/user_order_response.dart';
import '../../../../../../../../../domain/util.dart';

part 'user_reject_orders_cubit.freezed.dart';
part 'user_reject_orders_state.dart';

@injectable
class UserRejectOrdersCubit
    extends BaseCubit<UserRejectOrdersBuildable, UserRejectOrdersListenable> {
  UserRejectOrdersCubit() : super(UserRejectOrdersBuildable());

  void setInitialOrderType(OrderType orderType) {
    build((buildable) => buildable.copyWith(orderType: orderType));
  }
}

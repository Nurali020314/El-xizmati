import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'my_inactive_ads_cubit.freezed.dart';

part 'my_inactive_ads_state.dart';

@Injectable()
class MyInactiveAdsCubit
    extends BaseCubit<MyInactiveAdsBuildable, MyInactiveAdsListenable> {
  MyInactiveAdsCubit() : super(const MyInactiveAdsBuildable());
}

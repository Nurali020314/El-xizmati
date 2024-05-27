import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/domain/models/ad/ad_transaction_type.dart';

import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'create_ad_result_cubit.freezed.dart';
part 'create_ad_result_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit() : super(PageState());

  void setInitialParams(int adId, AdTransactionType type) {
    logger.w("result page - adId = $adId, adTransactionType = $type");
    updateState((state) => state.copyWith(adId: adId, adTransactionType: type));
  }
}
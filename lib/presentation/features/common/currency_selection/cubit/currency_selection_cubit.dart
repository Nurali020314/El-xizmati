import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/data/datasource/network/responses/currencies/currency_response.dart';
import 'package:onlinebozor/data/repositories/ad_creation_repository.dart';

import '../../../../../../core/enum/enums.dart';

part 'currency_selection_cubit.freezed.dart';
part 'currency_selection_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this.repository) : super(PageState()) {
    getItems();
  }

  final AdCreationRepository repository;

  Future<void> getItems() async {
    try {
      final items = await repository.getCurrenciesForCreationAd();
      logger.i(items.toString());
      updateState(
        (state) => state.copyWith(
          items: items,
          loadState: LoadingState.success,
        ),
      );
    } catch (exception) {
      logger.e(exception.toString());
      updateState((state) => state.copyWith(loadState: LoadingState.error));
    }
  }
}
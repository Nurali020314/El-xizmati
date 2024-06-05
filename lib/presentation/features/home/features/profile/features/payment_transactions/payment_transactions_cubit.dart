import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/core/handler/future_handler_exts.dart';
import 'package:onlinebozor/data/repositories/payment_repository.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/presentation/support/extensions/extension_message_exts.dart';

part 'payment_transactions_cubit.freezed.dart';
part 'payment_transactions_state.dart';

@injectable
class PaymentTransactionsCubit
    extends BaseCubit<PaymentTransactionsState, PaymentTransactionsEvent> {
  final PaymentRepository _paymentTransactionRepository;

  PaymentTransactionsCubit(
    this._paymentTransactionRepository,
  ) : super(PaymentTransactionsState()) {
    getController();
  }

  Future<void> getController() async {
    try {
      final controller = states.controller ?? getAdsController(status: 1);
      updateState((state) => state.copyWith(controller: controller));
    } catch (e, stackTrace) {
      logger.e(e.toString(), error: e, stackTrace: stackTrace);
      stateMessageManager.showErrorSnackBar(e.toString());
    } finally {
      logger.i(states.controller);
    }
  }

  PagingController<int, dynamic> getAdsController({
    required int status,
  }) {
    final controller = PagingController<int, dynamic>(
      firstPageKey: 1,
      invisibleItemsThreshold: 100,
    );
    logger.i(states.controller);

    controller.addPageRequestListener(
      (pageKey) async {
        _paymentTransactionRepository
            .getPaymentTransactions(
              pageSize: 20,
              pageIndex: pageKey,
            )
            .initFuture()
            .onStart(() {})
            .onSuccess((data) {
              if (data.length <= 19) {
                controller.appendLastPage(data);
                logger.i(states.controller);
                return;
              }
              controller.appendPage(data, pageKey + 1);
            })
            .onError((error) {
              controller.error = error;
              if (error.isRequiredShowError) {
                stateMessageManager
                    .showErrorBottomSheet(error.localizedMessage);
              }
            })
            .onFinished(() {})
            .executeFuture();
      },
    );
    return controller;
  }
}
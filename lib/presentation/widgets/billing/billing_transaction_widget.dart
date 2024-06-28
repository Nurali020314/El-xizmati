import 'package:flutter/material.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/billing/billing_transaction.dart';
import 'package:onlinebozor/presentation/support/extensions/mask_formatters.dart';
import 'package:onlinebozor/presentation/support/extensions/resource_exts.dart';

class BillingTransactionWidget extends StatelessWidget {
  const BillingTransactionWidget({
    super.key,
    required this.transaction,
    required this.onClicked,
  });

  final BillingTransaction transaction;
  final VoidCallback onClicked;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onClicked(),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  transaction.payDate.s(14).w(600),
                  SizedBox(width: 12),
                  Expanded(
                    child: transaction.transactionType
                        .getTransactionTypeLocalizedName()
                        .s(14)
                        .w(400)
                        // .c(transaction.transactionType.getTypeColor())
                        .copyWith(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                        ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: transaction.note
                        .s(12)
                        .w(500)
                        .copyWith(maxLines: 3, overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  transaction.transactionType
                      .getPaymentTypeLocalizedName()
                      .s(14)
                      .w(600),
                  SizedBox(width: 12),
                  Expanded(
                    child:
                        "${priceMaskFormatter.formatDouble(transaction.amount)} ${Strings.currencyUzs}"
                            .toString()
                            .w(500)
                            .s(14)
                            .c(transaction.transactionType.getPriceColor())
                            .copyWith(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                            ),
                  ),
                ],
              ),
              // SizedBox(height: 12),
              // "type = ${transaction.transactionType.name} \n action = ${transaction.transactionAction.name} \n state = ${transaction.balanceState.name}"
              //     .s(12)
              //     .w(500),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

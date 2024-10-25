import 'package:El_xizmati/data/datasource/network/responses/balance/user_deposit_balance_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/realpay/real_pay_card_response.dart';
import 'package:El_xizmati/data/datasource/network/services/private/card_service.dart';
import 'package:El_xizmati/data/datasource/preference/auth_preferences.dart';
import 'package:El_xizmati/data/datasource/preference/user_preferences.dart';
import 'package:El_xizmati/data/error/app_locale_exception.dart';

class CardRepository {
  final AuthPreferences _authPreferences;
  final CardService _cardService;
  final UserPreferences _userPreferences;

  CardRepository(
    this._authPreferences,
    this._cardService,
    this._userPreferences,
  );

  Future<UserDepositBalance> getDepositCardBalance() async {
    if (_authPreferences.isNotAuthorized) throw NotAuthorizedException();
    if (_userPreferences.isNotIdentified) throw NotIdentifiedException();

    final root = await _cardService.getDepositCardBalance();
    final response = UserDepositBalanceRootResponse.fromJson(root.data).data;
    return response;
  }

  Future<List<RealPayCard>> getUserDebitCards() async {
    final root = await _cardService.getUserDebitCards();
    final response = RealPayCardRootResponse.fromJson(root.data).data.data;
    return response;
  }

  Future<void> removeCard(String cardId) async {
    final pinflOrTin = _userPreferences.tinOrPinfl;
    final root = await _cardService.removeCard(cardId, pinflOrTin);
    return;
  }
}

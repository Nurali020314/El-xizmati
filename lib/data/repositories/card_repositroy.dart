import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/hive/storages/language_storage.dart';
import 'package:onlinebozor/data/datasource/hive/storages/user_storage.dart';
import 'package:onlinebozor/data/datasource/network/constants/rest_constants.dart';
import 'package:onlinebozor/data/datasource/network/extensions/rest_mappers.dart';
import 'package:onlinebozor/data/datasource/network/responses/balance/user_deposit_balance_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/realpay/real_pay_card_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/realpay/real_pay_merchant_token_response.dart';
import 'package:onlinebozor/data/datasource/network/services/card_service.dart';
import 'package:onlinebozor/data/error/app_locale_exception.dart';
import 'package:onlinebozor/data/repositories/state_repository.dart';
import 'package:onlinebozor/data/repositories/user_repository.dart';

@LazySingleton()
class CardRepository {
  CardRepository(
    this._cardService,
    this._languageStorage,
    this._stateRepository,
    this._userRepository,
    this._userStorage,
  );

  final CardService _cardService;
  final LanguageStorage _languageStorage;
  final StateRepository _stateRepository;
  final UserRepository _userRepository;
  final UserStorage _userStorage;

  Future<UserDepositBalance> getDepositCardBalance() async {
    if (_stateRepository.isNotAuthorized()) throw NotAuthorizedException();
    if (_userRepository.isNotIdentified()) throw NotIdentifiedException();

    final root = await _cardService.getDepositCardBalance();
    final response = UserDepositBalanceRootResponse.fromJson(root.data).data;
    return response;
  }

  Future<RealPayMerchantToken?> getRealPayAddCardMerchantToken() async {
    final root = await _cardService.getAddCardMerchantToken(
      _userStorage.pinflOrTin,
      RestConstants.REAL_PAY_REDIRECT_URI,
    );
    final response = RealPayMerchantTokenRootResponse.fromJson(root.data).data;
    return response;
  }

  Future<List<RealPayCard>> getAddedCards() async {
    final root = await _cardService.getAddedCards();
    final response = RealPayCardRootResponse.fromJson(root.data).data.data;
    return response;
  }

  Future<void> removeCard(String cardId) async {
    final pinflOrTin = _userStorage.pinflOrTin;
    final root = await _cardService.removeCard(cardId, pinflOrTin);
    return;
  }

  String generateAddCardUrl(String merchantToken) {
    var language = _languageStorage.language.getRestCode();
    return "https://payment.realpay.uz/?token=$merchantToken&lang=$language";
  }
}

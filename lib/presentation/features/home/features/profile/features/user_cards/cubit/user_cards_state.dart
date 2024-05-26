part of 'user_cards_cubit.dart';

@freezed
class PageState with _$PageState {
  const PageState._();

  const factory PageState({
    @Default("") String userFullName,
    @Default(0) double depositBalance,
    @Default(LoadingState.loading) LoadingState balanceState,
    @Default(LoadingState.loading) LoadingState cardsState,
    @Default([]) List<RealPayCard> addedCards,
  }) = _PageState;

  List<UserCard> get cards {
    var cards = [
      UserCard(
          id: "1",
          balance: depositBalance,
          cardHolder: userFullName,
          cardName: Strings.userCardDepositCardName,
          cardPan: Strings.userCardDepositCardPublisherName,
          isDeposit: true,
          cardLogo: Assets.images.icCardWallet)
    ];
    cards.addAll(
      addedCards
          .map(
            (e) => UserCard(
              id: e.cardId,
              balance: e.balance / 100,
              cardHolder: e.cardHolder,
              cardName: e.bankName,
              cardPan: e.maskedPan,
              isDeposit: false,
              cardLogo: e.isHumo
                  ? Assets.images.icCardHumo
                  : Assets.images.icCardUzcard,
            ),
          )
          .toList(),
    );
    return cards;
  }
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}
